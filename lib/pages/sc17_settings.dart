import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/pages/sc2_login.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Sc17Settings extends StatefulWidget {
  const Sc17Settings({Key? key}) : super(key: key);

  @override
  _Sc17SettingsState createState() => _Sc17SettingsState();
}

class _Sc17SettingsState extends State<Sc17Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorConst.pink,
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: ColorConst.pink),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).push(PageTransition(
                    child: Sc2Login(), type: PageTransitionType.rightToLeft));
              });
            },
            child: Text(
              "Logout".toUpperCase(),
              style: GoogleFonts.nunito(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
