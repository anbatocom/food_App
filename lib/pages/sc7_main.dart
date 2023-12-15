import 'package:flutter/material.dart';
import 'package:food_app_example/models/item_food.dart';
import 'package:google_fonts/google_fonts.dart';

class Sc7Main extends StatelessWidget {
  final List<ItemFood> foodItems;
  const Sc7Main({Key? key, required this.foodItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
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
                      child: Image.asset(foodItems[index].imagePathFood)),
                )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${foodItems[index].nameFood}",
                      style: GoogleFonts.nunito(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "\$${foodItems[index].cost}",
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
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          height: 2.0,
        );
      },
    );
  }
}
