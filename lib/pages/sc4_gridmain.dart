import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/svg_asset.dart';
import 'package:food_app_example/models/favorite_food.dart';
import 'package:food_app_example/models/restaurant.dart';
import 'package:food_app_example/pages/sc6_details_restaurant.dart';
import 'package:food_app_example/services/firebase_functions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class GridMain extends StatefulWidget {
  final List<dynamic> items;

  GridMain({required this.items});

  @override
  _GridMainState createState() => _GridMainState();
}

class _GridMainState extends State<GridMain> {
  List<FavoriteFood> favFood = [];
  void initState() {
    super.initState();
  }

  void _onItemPressed(Restaurant restaurantInfo) {
    Navigator.of(context).push(PageTransition(
        child: Sc6DetailsRestaurant(restaurantInfo: restaurantInfo),
        type: PageTransitionType.rightToLeft));
  }

  @override
  Widget build(BuildContext context) {
    return widget.items.isEmpty
        ? Center(child: Text("Không có dữ liệu"))
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              Restaurant restaurantInfo =
                  Restaurant.fromJson(widget.items[index]);
              return InkWell(
                onDoubleTap: () {
                  debugPrint("Test double touch card in list view");
                  restaurantInfo.isFavorite = !restaurantInfo.isFavorite;
                  setState(() {
                    if (restaurantInfo.isFavorite) {
                      favFood.clear();
                      // If the restaurant is marked as a favorite, add it to the list
                      favFood.add(FavoriteFood(
                        idUser: FirebaseAuth.instance.currentUser!.uid,
                        idRestaurant: restaurantInfo.id,
                      ));
                      addFavoriteRestaurantList(favFood);
                    } else {
                      // If the restaurant is not a favorite, remove it from the list
                      favFood.removeWhere(
                          (item) => item.idRestaurant == restaurantInfo.id);
                      deleteFavoriteRestaurantList(restaurantInfo.id);
                    }
                  });

                  debugPrint("${restaurantInfo.isFavorite.runtimeType}");
                  debugPrint("${restaurantInfo.isFavorite}");
                  updateFavoriteStatus("WiJt2PpANxyiRPar3kKU",
                      restaurantInfo.id, restaurantInfo.isFavorite);
                },
                onTap: () {
                  print("Test touch card in grid view");
                  _onItemPressed(restaurantInfo);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConst.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.asset(
                              restaurantInfo.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurantInfo.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                restaurantInfo.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.nunito(
                                  fontSize: 11,
                                  color: ColorConst.greyBold,
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(SvgAsset.IG_STAR),
                                      SvgPicture.asset(SvgAsset.IG_STAR),
                                      SvgPicture.asset(SvgAsset.IG_STAR),
                                      SvgPicture.asset(SvgAsset.IG_STAR),
                                      SvgPicture.asset(
                                        SvgAsset.IG_STAR,
                                        colorFilter: const ColorFilter.mode(
                                          ColorConst.grey,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    restaurantInfo.reviews + " reviews",
                                    style: GoogleFonts.nunito(fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
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
}
