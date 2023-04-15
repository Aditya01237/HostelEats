import 'package:flutter/material.dart';
import 'package:seller_app/mainScreens/history-screen.dart';
import 'package:seller_app/mainScreens/new-orders-screen.dart';
import 'package:seller_app/mainScreens/order-details-screen.dart';
import 'package:seller_app/mainScreens/past-screen.dart';

import '../auth/auth_screen.dart';
import '../global/global.dart';
import '../mainScreens/home_screen.dart';

class MyDrawer extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                    sharedPreferences!.getString("name")!,
                  style: TextStyle(color: Colors.black, fontSize: 30, fontFamily: "Train",fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20,),

          //body drawer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 1.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.black,),
                    title: const Text(
                      "Home",
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.monetization_on, color: Colors.black,),
                  //   title: const Text(
                  //     "My Earnings",
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  //   onTap: ()
                  //   {
                  //
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.reorder, color: Colors.black,),
                    title: const Text(
                      "New orders",
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> NewOrdersScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_shipping, color: Colors.black,),
                    title: const Text(
                      "Current - Orders",
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.playlist_add_check, color: Colors.black,),
                    title: const Text(
                      "Past - Orders",
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> PastScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.black,),
                    title: const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                    onTap: ()
                    {
                      firebaseAuth.signOut().then((value){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
