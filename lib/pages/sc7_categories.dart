// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_example/models/item_food.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/svg_asset.dart';
import 'package:food_app_example/pages/sc7_main.dart';
import 'package:food_app_example/widgets/custom_app_bar2.dart';

class Sc7Categories extends StatefulWidget {
  final List<ItemFood> foodItems;
  const Sc7Categories({
    Key? key,
    required this.foodItems,
  }) : super(key: key);

  @override
  _Sc7CategoriesState createState() => _Sc7CategoriesState();
}

class _Sc7CategoriesState extends State<Sc7Categories> {
  List<String> Options = ["STARTERS", "MAIN", "SIDES", "DESSERTS"];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar2(
          icons: const [
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              color: Colors.white,
            )
          ],
          title: Text(
            "ALL CATEGORIES",
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Column(children: <Widget>[
            SizedBox(
              height: 68,
              width: double.infinity,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Options.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(children: [
                                Container(
                                  decoration: _selectedIndex == index
                                      ? const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: ColorConst.pink)),
                                        )
                                      : null,
                                  child: _selectedIndex == index
                                      ? Text(Options[index],
                                          style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))
                                      : Text(Options[index],
                                          style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 25)
                              ]),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.1),
            ),
            Expanded(child: Sc7Main(foodItems: widget.foodItems))
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 50,
          color: ColorConst.whiteSmoke,
          child: Center(
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                SvgAsset.IG_ROTATE_CW,
              ),
            ),
          ),
        ));
  }
}
