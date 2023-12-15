import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/svg_asset.dart';
import 'package:food_app_example/models/order_list.dart';
import 'package:food_app_example/pages/sc15_list_food_order.dart';
import 'package:food_app_example/widgets/custom_app_bar2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Sc15OrderHistory extends StatefulWidget {
  const Sc15OrderHistory({Key? key}) : super(key: key);

  @override
  _Sc15OrderHistoryState createState() => _Sc15OrderHistoryState();
}

class _Sc15OrderHistoryState extends State<Sc15OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        icons: const [
          Icon(
            Icons.search,
            color: ColorConst.white,
          ),
          Icon(Icons.settings, color: ColorConst.white)
        ],
        title: Text(
          "order history".toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Order")
                .doc("${FirebaseAuth.instance.currentUser!.email}")
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child: Text("Không có dữ liệu"));
              } else {
                List<dynamic> orderData = snapshot.data!['OrderDate'];
                List<dynamic> reversedOrderData = orderData.reversed.toList();
                return ListView.builder(
                  itemCount: orderData.length,
                  itemBuilder: (context, index) {
                    OrderList orderItems =
                        OrderList.fromJson(reversedOrderData[index]);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageTransition(
                            child: Sc15ListFoodOrder(orderList: orderItems),
                            type: PageTransitionType.rightToLeft));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorConst.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3))
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.asset(
                                              orderItems.imageOrderPath,
                                              fit: BoxFit.contain,
                                            )),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(orderItems.nameRestaurant,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700)),
                                          Text(orderItems.optionOrdering,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 12)),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      SvgAsset.IG_STAR),
                                                  SvgPicture.asset(
                                                      SvgAsset.IG_STAR),
                                                  SvgPicture.asset(
                                                      SvgAsset.IG_STAR),
                                                  SvgPicture.asset(
                                                      SvgAsset.IG_STAR),
                                                  SvgPicture.asset(
                                                      SvgAsset.IG_STAR,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              ColorConst.grey,
                                                              BlendMode.srcIn)),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(SvgAsset.IG_LIST),
                                          const SizedBox(width: 5),
                                          Text("${orderItems.orderTime}",
                                              style: GoogleFonts.nunito(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorConst.black)),
                                        ],
                                      ),
                                      Text(
                                        "\$ " "${orderItems.cost}",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConst.pink),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
