import 'package:flutter/material.dart';
import 'package:seller_app/mainScreens/itemsScreen.dart';
import 'package:seller_app/model/items.dart';
import 'package:seller_app/model/menus.dart';
import '../main.dart';
import 'item-detail-screen.dart';

class ItemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [
                  Colors.blueGrey,
                  Colors.greenAccent,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(2.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.mirror)),
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => ItemDetailsScreen(model: widget.model)));
          },
          title: Text(
            widget.model!.title!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "Train",
            ),
          ),
          subtitle: Text(
            widget.model!.shortInfo!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          trailing: Text(
            textScaleFactor: 1.5,
            "${widget.model!.price!.toString()} Rs",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
