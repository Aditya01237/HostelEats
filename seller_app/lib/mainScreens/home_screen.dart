import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/auth/auth_screen.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/uploadScreens/menu_screen.dart';
import 'package:seller_app/widgets/my_drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/menus.dart';
import '../widgets/info_design.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: Text(sharedPreferences!.getString("name")!,style: TextStyle(fontSize: 40,fontFamily: "Lobster"),),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (c) => MenuScreen()));
          },
              icon: Icon(
                Icons.post_add
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("seller")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus").snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(child: circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Menus model = Menus.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return InfoDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
