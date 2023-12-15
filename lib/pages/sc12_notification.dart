import 'package:flutter/material.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/widgets/custom_app_bar2.dart';
import 'package:google_fonts/google_fonts.dart';

class Sc12Notification extends StatefulWidget {
  const Sc12Notification({Key? key}) : super(key: key);

  @override
  _Sc12NotificationState createState() => _Sc12NotificationState();
}

class _Sc12NotificationState extends State<Sc12Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
          icons: const [
            Icon(Icons.search, color: ColorConst.white),
            Icon(Icons.settings, color: ColorConst.white)
          ],
          title: Text(
            "Notification".toUpperCase(),
            style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorConst.white),
          )),
      body: SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(ImgAsset.Hamburger,
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good food and its benefits",
                              style: GoogleFonts.nunito(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Good food makes cooking fun and easy. "
                              "We'll provide you with all the ingredients in your meal "
                              "kit that you need to make a delicious meal.",
                              style: GoogleFonts.nunito(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "15 mins",
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF5F5F5F)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: Colors.grey.withOpacity(0.5),
              );
            },
            itemCount: 10),
      ),
    );
  }
}
