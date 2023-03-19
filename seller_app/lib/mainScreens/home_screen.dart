import 'package:flutter/material.dart';
import 'package:seller_app/auth/auth_screen.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/uploadScreens/menu_screen.dart';
import 'package:seller_app/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(sharedPreferences!.getString("name")!,style: TextStyle(fontSize: 40,fontFamily: "Lobster"),),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (c) => MenuScreen()));
          },
              icon: Icon(
                Icons.post_add
              ))
        ],
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[700],
          ),
          onPressed: () {
            firebaseAuth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
            });
          },
          child: const Text("Logout"),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
