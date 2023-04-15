import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/mainScreens/home_screen.dart';
import 'package:seller_app/widgets/error_dialog.dart';
import 'package:seller_app/widgets/loading_dialog.dart';

import '../widgets/custom_login.dart';
import 'auth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //A GlobalKey object is created using the FormState class.
  // This key is used to identify and manipulate the form in the user interface.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Two TextEditingController objects are created for the email and password fields,
  // respectively. These objects are likely bound to the corresponding TextFormField
  // widgets in the user interface.

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //The formValidation function is called when the user attempts to submit the form.
  // This function is likely bound to a "Submit" button in the user interface.

  formValidation() {
    //The function first checks if both the email and password fields are not empty.
    // If they are not empty, it calls the loginNow function to attempt to log in
    // the user using the email and password provided.

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login
      loginNow();
    } else {
      //If either the email or password field is empty, it displays an error
      // dialog to the user with a message telling them to fill in both fields.
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: "Please write email/password");
          });
    }
  }

  //  this function attempts to sign in a user with the email and password entered in
  //  the corresponding text fields, and if the sign-in is successful, it sets some
  //  user data locally and navigates to the home screen. If there is an error during
  //  the sign-in process, an error dialog is displayed to the user.

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialog(message: "Checking Credentials");
        });

    //The function initializes a nullable User
    // object called currentUser to be used later.

    User? currentUser;

    //The function then uses the signInWithEmailAndPassword method from the
    // firebaseAuth instance to attempt to sign in the user. This method takes
    // the user's email and password as arguments and returns a Future that
    // resolves to an UserCredential object upon successful sign-in.

    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),

      //The then method is used on the Future returned by signInWithEmailAndPassword
      // to set the currentUser variable to the signed-in user
      // (accessed through the user property of the UserCredential object).
    )
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      //This method dismisses the loading dialog and shows an error dialog
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: error.message.toString());
          });
    });

    //After attempting to sign in the user, the code checks if currentUser is not null.
    // If it's not null, it calls the readDataAndSetDataLocally function with
    // currentUser as an argument. The then method is used to wait for the Future
    // returned by readDataAndSetDataLocally to complete.

    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    //use the FirebaseFirestore instance to access the seller collection in
    // the database, and retrieve the document with the ID that matches
    // currentUser.uid.
    //The get() method is called on the document reference
    // which returns a DocumentSnapshot that contains the data for the document.

    await FirebaseFirestore.instance
        .collection("seller")
        .doc(currentUser.uid)
        //the snapshot variable is used to retrieve the seller's
        // email, name, and avatar URL from the document's data,
        // and store them locally using shared preferences.
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        //in the callback function, the sharedPreferences object is used to set
        // several key-value pairs: "uid", "email", "name", and "photoUrl".
        // These values are retrieved from the DocumentSnapshot using the data()
        // method and accessing the relevant fields by name.
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!
            .setString("email", snapshot.data()!["sellerEmail"]);
        await sharedPreferences!
            .setString("name", snapshot.data()!["sellerName"]);
        await sharedPreferences!
            .setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);

        //After the Future returned by readDataAndSetDataLocally has completed, the
        // loading dialog is dismissed and the user is navigated to the HomeScreen
        // widget using the Navigator.push method.

        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      } else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                "images/seller.png",
                height: 350,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(240, 50),
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            onPressed: () {
              formValidation();
            },
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
