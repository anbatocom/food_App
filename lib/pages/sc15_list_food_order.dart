import 'package:flutter/material.dart';
import 'package:food_app_example/const/color_const.dart';

import 'package:food_app_example/models/item_food.dart';
import 'package:food_app_example/models/order_list.dart';
import 'package:food_app_example/widgets/custom_app_bar2.dart';
import 'package:google_fonts/google_fonts.dart';

class Sc15ListFoodOrder extends StatefulWidget {
  final OrderList orderList;
  const Sc15ListFoodOrder({Key? key, required this.orderList})
      : super(key: key);

  @override
  _Sc15ListFoodOrderState createState() => _Sc15ListFoodOrderState();
}

class _Sc15ListFoodOrderState extends State<Sc15ListFoodOrder> {
  late OrderList _currentOrderList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentOrderList = widget.orderList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
          icons: [
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
            "List Food Order",
            style: GoogleFonts.nunito(
                color: ColorConst.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )),
      body: SafeArea(
        child: ListView.separated(
          itemCount: _currentOrderList.foodOrdered.length,
          itemBuilder: (BuildContext context, int index) {
            ItemFood itemFoodOfOrder =
                ItemFood.fromJson(_currentOrderList.foodOrdered[index]);
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                child: Row(
                  children: [
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(itemFoodOfOrder.imagePathFood)),
                    )),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${itemFoodOfOrder.nameFood}",
                          style: GoogleFonts.nunito(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "\$${itemFoodOfOrder.cost}",
                          style: GoogleFonts.nunito(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1.0,
              color: ColorConst.grey,
            );
          },
        ),
      ),
    );
  }
}
