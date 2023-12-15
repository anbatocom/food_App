import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/const/svg_asset.dart';

import 'package:food_app_example/models/item_credit_cards.dart';
import 'package:food_app_example/widgets/custom_app_bar2.dart';
import 'package:google_fonts/google_fonts.dart';

class Sc10PaymentMethod extends StatefulWidget {
  const Sc10PaymentMethod({Key? key}) : super(key: key);

  @override
  _Sc10PaymentMethodState createState() => _Sc10PaymentMethodState();
}

class _Sc10PaymentMethodState extends State<Sc10PaymentMethod> {
  final List<ItemCreditCards> _itemCreditCards = [
    ItemCreditCards(
        id: "**** **** **** 2779", path: SvgPicture.asset(SvgAsset.IG_VISA)),
    ItemCreditCards(
        id: "adaff_hs@gmail.com", path: SvgPicture.asset(SvgAsset.IG_PAYPAL)),
    ItemCreditCards(
        id: "**** **** **** 1334",
        path: SvgPicture.asset(SvgAsset.IG_MASTERCARD))
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFFAF7F7),
      appBar: CustomAppBar2(
          icons: const [
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            )
          ],
          title: Text(
            "Payment method".toUpperCase(),
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          )),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: InkWell(
                onTap: () {
                  debugPrint("Add new credit card");
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    SvgAsset.IG_WALLET,
                                    colorFilter: const ColorFilter.mode(
                                        ColorConst.pink, BlendMode.srcIn),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Add a new card",
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              SvgAsset.IG_CHEVRON_RIGHT,
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-1, -0.6),
            child: Container(
              margin: const EdgeInsets.only(bottom: 50, left: 15),
              child: Text(
                "Bank Accounts".toUpperCase(),
                style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-1, -0.5),
            child: InkWell(
              onTap: () {
                debugPrint("Bank Accounts");
              },
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    color: ColorConst.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text("Frankin Campbell - ***6383",
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            SvgAsset.IG_CHEVRON_RIGHT,
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ),
          Align(
            alignment: const Alignment(-1, -0.3),
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                "credit cards".toUpperCase(),
                style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: 120,
              color: Colors.white,
              child: ListView.separated(
                itemCount: _itemCreditCards.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      debugPrint(_itemCreditCards[index].id);
                    },
                    child: SizedBox(
                      height: 40,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(_itemCreditCards[index].id,
                                        style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              _itemCreditCards[index].path,
                            ],
                          )),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 1.0,
                    color: Colors.grey.withOpacity(0.1),
                  );
                },
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                ImgAsset.Successfully,
                width: 280,
              )),
        ],
      ),
    ));
  }
}
