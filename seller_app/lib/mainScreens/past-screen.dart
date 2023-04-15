import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/widgets/history-order-card.dart';
import 'package:seller_app/widgets/progress_bar.dart';
import '../assistantMethods/assistant-methods.dart';
import '../widgets/past-order-card.dart';
import '../widgets/simple-app-bar.dart';

class PastScreen extends StatefulWidget {
  const PastScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<PastScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // The app bar widget that displays the title of the screen.
        appBar: SimpleAppBar(title: "Past Orders"),
        body: StreamBuilder<QuerySnapshot>(
          // The stream that listens for completed orders for the current seller.
          stream: FirebaseFirestore.instance
              .collection("pastOrders")
              .where("status", isEqualTo: "normal")
              .where("sellerUID", isEqualTo: sharedPreferences!.getString("uid"))
              .snapshots(),
          builder: (context, snapshot) {
            // Check if there's data available in the stream.
            if (snapshot.hasData) {
              // If there's data, display a ListView of HistoryOrderCard widgets.
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // Fetch details about each item in the order from Firestore.
                  return FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("items")
                        .where(
                      "itemID",
                      whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data() as Map<String, dynamic>)["productIDs"]),
                    )
                        .where("sellerUID", whereIn: (snapshot.data!.docs[index].data() as Map<String, dynamic>)["uid"])
                        .orderBy("publishedDate", descending: true)
                        .get(),
                    builder: (context, snapshotItems) {
                      // Check if there's data available in the snapshot of the items.
                      if (snapshotItems.hasData) {
                        // If there's data, display a HistoryOrderCard widget for the order.
                        return PastOrderCard(
                          itemCount: snapshotItems.data!.docs.length,
                          data: snapshotItems.data!.docs,
                          orderID: snapshot.data!.docs[index].id,
                          seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data() as Map<String, dynamic>)["productIDs"]),
                        );
                      } else {
                        // If there's no data, display a progress indicator.
                        return Center(child: circularProgress());
                      }
                    },
                  );
                },
              );
            } else {
              // If there's no data, display a progress indicator.
              return Center(child: circularProgress());
            }
          },
        ),
      ),
    );
  }
}
