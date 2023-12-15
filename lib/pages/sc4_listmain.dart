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

class ListMain extends StatefulWidget {
  final List<dynamic> items;

  ListMain({required this.items});

  @override
  _ListMainState createState() => _ListMainState();
}

class _ListMainState extends State<ListMain> {
  List<FavoriteFood> favFood = [];
  int doubleTabCount = 0;
  @override
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
        : ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              Restaurant restaurantInfo =
                  Restaurant.fromJson(widget.items[index]);

              return InkWell(
                onDoubleTap: () async {
                  debugPrint("Test double touch card in list view");

                  setState(() {
                    restaurantInfo.isFavorite = !restaurantInfo.isFavorite;

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
                  debugPrint("Test touch card in list view");
                  _onItemPressed(restaurantInfo);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                          height: 200,
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
                          padding: const EdgeInsets.all(15.0),
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
                              const SizedBox(height: 10),
                              Text(
                                restaurantInfo.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.nunito(
                                  fontSize: 11,
                                  color: ColorConst.greyBold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                      (starIndex) => SvgPicture.asset(
                                        SvgAsset.IG_STAR,
                                        colorFilter: ColorFilter.mode(
                                            starIndex < 4
                                                ? Colors.pink
                                                : ColorConst.grey,
                                            BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
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
