import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/const/svg_asset.dart';
import 'package:food_app_example/widgets/custom_app_bar2.dart';
import 'package:google_fonts/google_fonts.dart';

class Sc16Reviews extends StatefulWidget {
  const Sc16Reviews({Key? key}) : super(key: key);

  @override
  _Sc16ReviewsState createState() => _Sc16ReviewsState();
}

class _Sc16ReviewsState extends State<Sc16Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
          icons: [
            const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            const Icon(
              Icons.search,
              color: Colors.white,
            )
          ],
          title: Text(
            "reviews".toUpperCase(),
            style: GoogleFonts.nunito(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    debugPrint("test reviews $index");
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(ImgAsset.Avatar),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Anna Rose",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  Text("2 hours ago",
                                      style: GoogleFonts.nunito(
                                          fontSize: 13,
                                          color: ColorConst.greyBold)),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(SvgAsset.IG_STAR),
                                SvgPicture.asset(SvgAsset.IG_STAR),
                                SvgPicture.asset(SvgAsset.IG_STAR),
                                SvgPicture.asset(SvgAsset.IG_STAR),
                                SvgPicture.asset(SvgAsset.IG_STAR,
                                    colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(255, 102, 81, 81),
                                        BlendMode.srcIn)),
                              ],
                            ),
                          ],
                        ),
                        Text(
                            "We had a chance to try some of the food from the restaurant prepared for the food festival, and the chicken croquettes were simply amazing! ",
                            style: GoogleFonts.nunito(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ])));
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              );
            },
            itemCount: 10),
      ),
    );
  }
}
