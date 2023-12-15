import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';

import 'package:food_app_example/pages/sc2_login.dart';
import 'package:page_transition/page_transition.dart';

class Sc1Lobby extends StatefulWidget {
  const Sc1Lobby({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Sc1LobbyState createState() => _Sc1LobbyState();
}

class _Sc1LobbyState extends State<Sc1Lobby> {
  late final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint("Check switch screen");
      Navigator.of(context).pushReplacement(PageTransition(
          child: const Sc2Login(), type: PageTransitionType.rightToLeft));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: ColorConst.pink,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100.0))),
                child: Center(
                  child: Image.asset(ImgAsset.PandaLogo),
                ),
              ),
            ),
            Expanded(
              child: Image.asset(ImgAsset.Shipper),
            )
          ],
        ),
      ),
    );
  }
}
