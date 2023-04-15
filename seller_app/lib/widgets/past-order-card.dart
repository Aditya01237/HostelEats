import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/mainScreens/pastorderdetails.dart';
import 'package:seller_app/model/items.dart';
import '../mainScreens/historyorderDetails.dart';
import '../mainScreens/order-details-screen.dart';

class PastOrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  PastOrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => PastOrderDetails(orderID: orderID)));
      },
      title: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.blueGrey,
                Colors.greenAccent,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(2.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.mirror),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: itemCount! * 100,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Items model =
            Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(
                model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}

Widget placedOrderDesignWidget(
    Items model, BuildContext context, seperateQuantitiesList) {
  return ListTile(
    tileColor: Colors.blueGrey,
    title: Text(
      model!.title!,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontFamily: "Acme",
      ),
    ),
    subtitle: Text(
      model!.shortInfo!,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: "Acme",
      ),
    ),
    trailing: Text(
      textScaleFactor: 1.5,
      "Rs ${model!.price!.toString()}",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: "Acme",
      ),
    ),
  );
}
