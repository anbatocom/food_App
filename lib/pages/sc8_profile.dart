import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/const/svg_asset.dart';
import 'package:food_app_example/pages/sc10_payment_method.dart';
import 'package:food_app_example/pages/sc17_settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Sc8Profile extends StatefulWidget {
  final void Function(int) onIndexChanged;
  const Sc8Profile({Key? key, required this.onIndexChanged}) : super(key: key);
  @override
  _Sc8ProfileState createState() => _Sc8ProfileState();
}

class _Sc8ProfileState extends State<Sc8Profile> {
  final PageController controller = PageController();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 220,
        flexibleSpace: Stack(alignment: Alignment.bottomRight, children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImgAsset.Rectangle),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(ColorConst.pink, BlendMode.modulate))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  )),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: InkWell(
                              onTap: () {},
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(ImgAsset.Avatar),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${currentUser!.displayName}",
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24),
                              ),
                              Text(
                                "${currentUser!.email}",
                                style: GoogleFonts.nunito(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 8.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 8.0,
                      ))),
              width: double.infinity,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    debugPrint("Order history");

                    widget.onIndexChanged(1);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              child: SvgPicture.asset(SvgAsset.IG_ORDER_LIST),
                            ),
                          ),
                          Text("Order History",
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SvgPicture.asset(SvgAsset.IG_CHEVRON_RIGHT),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    debugPrint("Payment Method");
                    Navigator.of(context).push(PageTransition(
                        child: Sc10PaymentMethod(),
                        type: PageTransitionType.rightToLeft));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: ColorConst.greenLeaf,
                              child: SvgPicture.asset(SvgAsset.IG_WALLET),
                            ),
                          ),
                          Text("Payment Method",
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SvgPicture.asset(SvgAsset.IG_CHEVRON_RIGHT),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    debugPrint("Reward Credits");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: ColorConst.orangeBold,
                              radius: 30,
                              child: SvgPicture.asset(SvgAsset.IG_BIG_STAR),
                            ),
                          ),
                          Text("Reward Credits",
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SvgPicture.asset(SvgAsset.IG_CHEVRON_RIGHT),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    debugPrint("Settings");
                    Navigator.of(context).push(PageTransition(
                        child: Sc17Settings(),
                        type: PageTransitionType.leftToRight));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: ColorConst.orange,
                              radius: 30,
                              child: SvgPicture.asset(SvgAsset.IG_SETTING),
                            ),
                          ),
                          Text("Settings",
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SvgPicture.asset(SvgAsset.IG_CHEVRON_RIGHT),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    debugPrint("Invite Friends");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: ColorConst.greenShort,
                              radius: 30,
                              child: SvgPicture.asset(SvgAsset.IG_PROFILE_TWO),
                            ),
                          ),
                          Text("Invite Friends",
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SvgPicture.asset(SvgAsset.IG_CHEVRON_RIGHT),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
