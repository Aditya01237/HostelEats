import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/model/items.dart';
import '../mainScreens/order-details-screen.dart';


class OrderCard extends StatelessWidget
{
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDetailsScreen(orderID: orderID)));
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
          itemBuilder: (context, index)
          {
            Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}




Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList)
{
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
        fontSize: 20,
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
  // return Container(
  //   width: MediaQuery.of(context).size.width,
  //   height: 120,
  //   color: Colors.grey[200],
  //   child: Row(
  //     children: [
  //       Image.network(model.thumbnailUrl!, width: 120,),
  //       const SizedBox(width: 10.0,),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //
  //             const SizedBox(
  //               height: 20,
  //             ),
  //
  //             Row(
  //               mainAxisSize: MainAxisSize.max,
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     model.title!,
  //                     style: const TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 16,
  //                       fontFamily: "Acme",
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 const Text(
  //                   "Rs ",
  //                   style: TextStyle(fontSize: 16.0, color: Colors.blue),
  //                 ),
  //                 Text(
  //                   model.price.toString(),
  //                   style: const TextStyle(
  //                     color: Colors.blue,
  //                     fontSize: 18.0,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //
  //             const SizedBox(
  //               height: 20,
  //             ),
  //
  //             Row(
  //               children: [
  //                 const Text(
  //                     "x ",
  //                     style: TextStyle(
  //                       color: Colors.black54,
  //                       fontSize: 14,
  //                     ),
  //                 ),
  //                 Expanded(
  //                   child: Text(
  //                     seperateQuantitiesList,
  //                     style: const TextStyle(
  //                       color: Colors.black54,
  //                       fontSize: 30,
  //                       fontFamily: "Acme",
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //
  //           ],
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}
