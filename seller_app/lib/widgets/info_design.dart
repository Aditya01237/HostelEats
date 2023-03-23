import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../mainScreens/itemsScreen.dart';
import '../model/menus.dart';

class InfoDesignWidget extends StatefulWidget
{
  Menus? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}



class _InfoDesignWidgetState extends State<InfoDesignWidget> {

  deleteMenu(String menuID)
  {
    FirebaseFirestore.instance.collection("seller")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Menu Deleted Successfully.");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
         Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 220.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 1.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.model!.menuTitle!,
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 40,
                      fontFamily: "Train",
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: ()
                    {
                      //delete menu
                      deleteMenu(widget.model!.menuId!);
                    },
                  ),
                ],
              ),
              // Text(
              //   widget.model!.menuInfo!,
              //   style: const TextStyle(
              //     color: Colors.grey,
              //     fontSize: 20,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
