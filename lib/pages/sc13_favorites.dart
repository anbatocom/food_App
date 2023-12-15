import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/models/restaurant.dart';
import 'package:food_app_example/pages/sc13_listFavorite.dart';
// import 'package:food_app_example/widgets/custom_app_bar2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../widgets/custom_app_bar2.dart';

class Sc13Favorites extends StatefulWidget {
  const Sc13Favorites({Key? key}) : super(key: key);

  @override
  _Sc13FavoritesState createState() => _Sc13FavoritesState();
}

class _Sc13FavoritesState extends State<Sc13Favorites> {
  final List<Restaurant> items = [
    Restaurant(
      id: Uuid().v4(),
      imagePath: ImgAsset.Sushi,
      title: "Tuna Sushi Platter (3 Types)",
      description:
          "Sushi Platter | Tuna (2 pcs), Semi-fatty Tuna (2 pcs).\nPrime Fatty Tuna(2pcs)",
      reviews: "298 reviews",
      // cost: '',
      isFavorite: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar2(
          icons: const [
            Icon(
              Icons.search,
              color: ColorConst.white,
            ),
            Icon(
              Icons.settings,
              color: ColorConst.white,
            )
          ],
          title: Text(
            "favorites".toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("favorite")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> favoriteSnapshot) {
            if (favoriteSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (favoriteSnapshot.hasError) {
              return Text("Error: ${favoriteSnapshot.error}");
            } else if (!favoriteSnapshot.hasData ||
                !favoriteSnapshot.data!.exists) {
              return Center(child: Text("Không có dữ liệu"));
            } else {
              List<String> idRestaurantList = [];
              List<dynamic> orderDateList = favoriteSnapshot.data!['favorite'];
              for (var order in orderDateList) {
                idRestaurantList.add(order['idRestaurant']);
              }
              // String? email = FirebaseAuth.instance.currentUser!.email;
              // debugPrint(email);
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("items")
                    .doc("WiJt2PpANxyiRPar3kKU")
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text("Không có dữ liệu");
                  } else {
                    // Extracting idRestaurant from the map
                    // Extracting items that match idRestaurant values
                    List<dynamic> itemsData = snapshot.data!['items'];
                   
                    List<dynamic> favoriteItems = itemsData
                        .where((item) =>
                            idRestaurantList.any((id) => item['id'] == id))
                        .toList();

                    return SafeArea(child: ListFavorite(items: favoriteItems));
                  }
                },
              );
            }
          },
        ));
  }
}
