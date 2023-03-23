import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/model/address.dart';
import '../mainScreens/new-orders-screen.dart';
import '../screens/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  ShipmentAddressDesign(
      {this.model,
      this.orderStatus,
      this.orderId,
      this.sellerId,
      this.orderByUser});

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewOrdersScreen()));
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
                                tileMode: TileMode.mirror)),
                        // width: MediaQuery.of(context).size.width - 40,
                        height: 50,
                        child: Center(
                          child: Text(
                            orderStatus == "ended"
                                ? "Go Back"
                                : "Order Delivered",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
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
                          icon: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                      await FlutterPhoneDirectCaller.callNumber(model!.phoneNumber!);
                      }),
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
