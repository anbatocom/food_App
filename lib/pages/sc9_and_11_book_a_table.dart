import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/const/svg_asset.dart';
import 'package:food_app_example/models/item_food.dart';
import 'package:food_app_example/models/order_list.dart';
import 'package:food_app_example/models/restaurant.dart';
import 'package:food_app_example/pages/sc_home.dart';
import 'package:food_app_example/widgets/custom_appbar3.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Sc9And11BookATable extends StatefulWidget {
  final Restaurant restaurantInfo;
  const Sc9And11BookATable({Key? key, required this.restaurantInfo})
      : super(key: key);

  @override
  _Sc9And11BookATableState createState() => _Sc9And11BookATableState();
}

class _Sc9And11BookATableState extends State<Sc9And11BookATable> {
  late Restaurant _currentRestaurantInfo;

  @override
  void initState() {
    super.initState();
    // Lưu trữ giá trị từ widget vào biến _currentRestaurantInfo
    _currentRestaurantInfo = widget.restaurantInfo;
  }

  final List<String> _list = [
    '2 Adults, 3 children',
    '1 Adults',
    '4 Adults, 4 children',
    '20 Adults',
    '1 Adults, 15 children',
    '10 Adults',
  ];
  List<int> selectedItems = [];
  int _visibleCountItem = 3;
  bool isTenItem = false;
  late String funStr = "View more";

  double totalCost = 0;
  DateTime _selectedDay = DateTime.now();
  late String _timeOrder = "8:30";
  late String _optionOrdering;
  List<ItemFood> foodsOrdering = [];
  final GlobalKey<FormState> _listKey = GlobalKey<FormState>();
  void loadMoreItem(int fullLength) {
    setState(() {
      _visibleCountItem = fullLength;
      funStr = "Short Item";
      isTenItem = true;
    });
  }

  void shortedItem() {
    setState(() {
      _visibleCountItem = 3;
      funStr = "View more";
      isTenItem = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar3(
        onSetDateTimeOrder: (DateTime d) {
          setState(() {
            _selectedDay = d;
          });
        },
        onSetTimeOrder: (String t) {
          setState(() {
            _timeOrder = t;
          });
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: ColorConst.grey.withOpacity(0.4), blurRadius: 5.0)
              ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ORDERING",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorConst.greyBold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Number of person",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: ColorConst.greyBold),
                        ),
                        SizedBox(
                          width: 240,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: _listKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: CustomDropdown<String>(
                                  hintText: 'Select Your Options',
                                  items: _list,
                                  maxlines: 1,
                                  validator: (p0) {
                                    if (p0 == null) {
                                      return "Hãy chọn khẩu phần";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _optionOrdering = value;
                                  },
                                  validateOnChange: true,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: ColorConst.grey.withOpacity(0.4), blurRadius: 5)
                ]),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("foods")
                        .doc("q1Y9S8bOVGf6TW1aXOOL")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Text("Không có dữ liệu");
                      } else {
                        List<dynamic> foodsData = snapshot.data!['foods'];
                        List<dynamic> foodItems = foodsData
                            .where((item) =>
                                item['idRestaurant'] ==
                                _currentRestaurantInfo.id)
                            .map((e) => ItemFood.fromJson(e))
                            .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "MENU",
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConst.greyBold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (isTenItem) {
                                        shortedItem();
                                      } else {
                                        loadMoreItem(foodItems.length);
                                      }
                                    },
                                    child: Text(
                                      funStr,
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: const Color.fromARGB(
                                              255, 39, 13, 25)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: _visibleCountItem,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  foodItems[index]
                                                      .imagePathFood,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  foodItems[index].nameFood,
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  "\$"
                                                  "${foodItems[index].cost}",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (selectedItems
                                                  .contains(index)) {
                                                selectedItems.remove(index);
                                                foodsOrdering.removeWhere(
                                                    (item) =>
                                                        item ==
                                                        foodItems[index]);
                                                totalCost -= double.parse(
                                                    foodItems[index].cost);
                                              } else {
                                                selectedItems.add(index);
                                                foodsOrdering
                                                    .add(foodItems[index]);
                                                totalCost += double.parse(
                                                    foodItems[index].cost);
                                              }
                                            });
                                          },
                                          child: selectedItems.contains(index)
                                              ? const CircleAvatar(
                                                  backgroundColor:
                                                      ColorConst.pink,
                                                  child: Icon(Icons.check,
                                                      color: ColorConst.white),
                                                )
                                              : const CircleAvatar(
                                                  backgroundColor:
                                                      ColorConst.grey,
                                                  child: Icon(Icons.check,
                                                      color: ColorConst.black),
                                                ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    height: 1,
                                    color: ColorConst.grey.withOpacity(0.2),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorConst.pink, // Màu nền của BottomAppBar
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: \$$totalCost",
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: ColorConst.white,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: double.infinity,
                child: InkWell(
                  onTap: (totalCost > 0 && _listKey.currentState!.validate())
                      ? () async {
                          try {
                            debugPrint("Test order button");
                            final currentUser =
                                FirebaseAuth.instance.currentUser;
                            List<Map<String, dynamic>> foodOrderedMapList =
                                foodsOrdering
                                    .map((itemFood) => itemFood.toJson())
                                    .toList();
                            OrderList newOrder = OrderList(
                                idUser: currentUser!.uid,
                                imageOrderPath:
                                    _currentRestaurantInfo.imagePath,
                                nameRestaurant: _currentRestaurantInfo.title,
                                orderTime: DateTime.now(),
                                optionOrdering: _optionOrdering,
                                cost: totalCost,
                                foodOrdered: foodOrderedMapList,
                                dayOrder: _selectedDay,
                                timeOrder: _timeOrder);
                            Map<String, dynamic> orderJson = newOrder.toJson();
                            // Lấy tham chiếu đến collection "Order"
                            CollectionReference orderCollection =
                                FirebaseFirestore.instance.collection('Order');
                            DocumentReference orderDocument =
                                orderCollection.doc("${currentUser.email}");
                            bool documentExists =
                                (await orderDocument.get()).exists;

                            if (documentExists) {
                              // Nếu tài liệu đã tồn tại, thêm dữ liệu mới vào tài liệu đó
                              await orderDocument.set(
                                {
                                  'OrderDate':
                                      FieldValue.arrayUnion([orderJson])
                                },
                                SetOptions(merge: true),
                              );
                            } else {
                              await orderDocument.set({
                                'OrderDate': [orderJson]
                              });
                            }
                          } catch (e) {
                            debugPrint("$e");
                          }

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 70),
                                  content: Column(
                                    children: [
                                      Image.asset(ImgAsset.TakeAway),
                                      Text("Thank You",
                                          style: GoogleFonts.nunito(
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Text("Your order is successfully",
                                          style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 35),
                                      SizedBox(
                                        height: 50,
                                        width: 150,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              await Navigator.of(context)
                                                  .pushReplacement(
                                                      PageTransition(
                                                          child: const ScHome(),
                                                          type:
                                                              PageTransitionType
                                                                  .rightToLeft));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorConst.pink),
                                            child: Text("OK",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      : null,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        "ORDER",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: ColorConst.white,
                            fontWeight: FontWeight.w700),
                      ),
                      SvgPicture.asset(SvgAsset.IG_ARROWRIGHT),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
