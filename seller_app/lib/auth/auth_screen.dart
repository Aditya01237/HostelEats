import 'package:flutter/material.dart';
import 'package:seller_app/auth/login_screeen.dart';
import 'package:seller_app/auth/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          automaticallyImplyLeading: false,
          title: const Text(
              "Hostel Eats",
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock,color: Colors.white),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.person,color: Colors.white),
                text: "Register",
              )
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 4,
          ),
        ),
        body: Container(
          color: Colors.blueGrey[200],
          child: TabBarView(
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
