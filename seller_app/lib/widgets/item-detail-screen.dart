import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/mainScreens/home_screen.dart';
import 'package:seller_app/model/items.dart';
import 'simple-app-bar.dart';


class ItemDetailsScreen extends StatefulWidget
{
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}




class _ItemDetailsScreenState extends State<ItemDetailsScreen>
{
  TextEditingController counterTextEditingController = TextEditingController();


  deleteItem(String itemID)
  {
    FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuId!)
        .collection("items")
        .doc(itemID)
        .delete().then((value)
    {
      FirebaseFirestore.instance
          .collection("items")
          .doc(itemID)
          .delete();

      Navigator.push(context, MaterialPageRoute(builder: (c)=>  HomeScreen()));
      Fluttertoast.showToast(msg: "Item Deleted Successfully.");
    });
  }

  updateItem(String itemID, int newPrice) {
    FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuId!)
        .collection("items")
        .doc(itemID)
        .update({
      "price": newPrice,
    })
        .then((value) {
      FirebaseFirestore.instance
          .collection("items")
          .doc(itemID)
          .update({
        "price": newPrice,
      });
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Item price updated successfully.");
    });
  }

  Future<void> _showUpdatePriceDialog() async {
    int? newPrice;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Price'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'New Price',
            ),
            onChanged: (value) {
              newPrice = int.tryParse(value)?.toInt();
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update'),
              onPressed: () {
                if (newPrice != null) {
                  updateItem(widget.model!.itemID!, newPrice!);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.model!.title.toString()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              widget.model!.thumbnailUrl.toString(),
              height: 220.0,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          //Image.network(widget.model!.thumbnailUrl.toString()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.price.toString() + " Rs",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: ()
                      {
                        //delete item
                        deleteItem(widget.model!.itemID!);
                      },
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
                                tileMode: TileMode.mirror)
                        ),
                        width: MediaQuery.of(context).size.width - 13,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Delete this Item",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: ()
                      {
                        _showUpdatePriceDialog();
                      },
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
                                tileMode: TileMode.mirror)
                        ),
                        width: MediaQuery.of(context).size.width - 13,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Update Price",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
