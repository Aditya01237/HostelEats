import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:seller_app/model/address.dart';
import '../external/whatsapp.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  const ShipmentAddressDesign(
      {super.key, this.model,
      this.orderStatus,
      this.orderId,
      this.sellerId,
      this.orderByUser});

  @override
  Widget build(BuildContext context) {
    String amount = "";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text('Address Details:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
            width: MediaQuery.of(context).size.width,
            child: Table(
              children: [
                TableRow(
                  children: [
                    const Center(
                      child: Text(
                        "Name",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Center(
                        child: Text(
                      model!.name!,
                      style: const TextStyle(fontSize: 15),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    const Center(
                      child: Text(
                        "Phone Number",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Center(
                      child: Text(
                        model!.phoneNumber!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Center(
                      child: Text(
                        "Fulladress",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Center(
                        child: Text(
                      model!.fullAddress!,
                      style: const TextStyle(fontSize: 15),
                    )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Fluttertoast.showToast(msg: "Your order has been confirmed.");
                        FirebaseFirestore.instance
                            .collection('orders')
                            .doc(orderId)
                            .get()
                            .then((docSnapshot) {
                          if (docSnapshot.exists) {
                            amount =
                                docSnapshot.data()!['totalAmount'].toString();
                            String str = "Thanks!\n${model!.name!}\n${model!.phoneNumber!}\n${model!.fullAddress!}\nTotal amount = \$$amount\nYour order has been confirmed";
                            openWhatsApp("91${model!.phoneNumber!}", str);
                          }
                        });
                        FirebaseFirestore.instance.collection('orders').doc(orderId).get().then((docSnapshot) {
                          if (docSnapshot.exists) {
                            // Copy the document to a new collection with the same ID
                            FirebaseFirestore.instance.collection('completedOrders').doc(orderId).set(docSnapshot.data()!);

                            // Delete the document from the original collection
                            FirebaseFirestore.instance.collection('orders').doc(orderId).delete();
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Colors.blueGrey,
                                  Colors.greenAccent,
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(2.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.mirror)),
                        // width: MediaQuery.of(context).size.width - 40,
                        height: 50,
                        child: Center(
                          child: Text(
                            orderStatus == "ended" ? "Go Back" : "Confirm",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                Colors.blueGrey,
                                Colors.greenAccent,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(2.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.mirror)),
                      // width: MediaQuery.of(context).size.width - 40,
                      height: 55,
                      child: IconButton(
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(
                                model!.phoneNumber!);
                          }),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Fluttertoast.showToast(msg: "Your Order Has Been Canceled.");
                        FirebaseFirestore.instance
                            .collection('orders')
                            .doc(orderId)
                            .delete()
                            .then((value) {
                          String str = "Sorry!\n${model!.name!}\n${model!.phoneNumber!}\n${model!.fullAddress!}\nYour Order Has Been Canceled.";
                          openWhatsApp("91${model!.phoneNumber!}", str);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Colors.blueGrey,
                                  Colors.greenAccent,
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(2.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.mirror)),
                        // width: MediaQuery.of(context).size.width - 40,
                        height: 50,
                        child: Center(
                          child: Text(
                            orderStatus == "ended" ? "Go Back" : "Cancel",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
