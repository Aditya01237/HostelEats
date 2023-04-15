import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/model/address.dart';
import '../external/whatsapp.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class PastAddressDesign extends StatelessWidget {
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  PastAddressDesign(
      {this.model,
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
          ), SizedBox(height: 15),
          Center(
            child: InkWell(
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
                      await FlutterPhoneDirectCaller.callNumber(
                          model!.phoneNumber!);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
