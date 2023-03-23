import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/auth/auth_screen.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp();
  runApp(const MyApp());
}
int itemCount = 0;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/auth': (context) => AuthScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: "Seller App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySplashScreen(),
    );
  }
}
