import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/pages/sc2_signup.dart';

import 'package:food_app_example/pages/sc_home.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Sc2Login extends StatefulWidget {
  const Sc2Login({Key? key}) : super(key: key);

  @override
  _Sc2LoginState createState() => _Sc2LoginState();
}

class _Sc2LoginState extends State<Sc2Login> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  FocusNode focusNodeUser = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  bool isDisplayKeyboard = false;
  bool isEmailCorrect = false;
  bool _isObscured = false;

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNodeUser.addListener(() {
      setState(() {
        isDisplayKeyboard = focusNodeUser.hasFocus;
      });
    });
    focusNodePassword.addListener(() {
      setState(() {
        isDisplayKeyboard = focusNodePassword.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _userEmailController.dispose();
    focusNodePassword.dispose();
    focusNodeUser.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImgAsset.BgLogin), fit: BoxFit.cover),
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: ColorConst.black,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image.asset(ImgAsset.PandaLogo),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 27, left: 27),
                      child: Form(
                        key: _fromKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              focusNode: focusNodeUser,
                              controller: _userEmailController,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 16, color: Colors.white),
                              validator: (value) {
                                if (_userEmailController.text.isEmpty) {
                                  return "Please enter your email";
                                }
                                if (!isEmailCorrect) {
                                  return "Input Email failed";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  isEmailCorrect =
                                      EmailValidator.validate(value);
                                });
                              },
                              decoration: const InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70))),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 30)),
                            TextFormField(
                              focusNode: focusNodePassword,
                              controller: _passwordController,
                              obscureText: !_isObscured,
                              validator: (value) {
                                if (_passwordController.text.isEmpty) {
                                  return "Please enter your password";
                                }
                                if (_passwordController.text.length < 8) {
                                  return "Limit 8 characters";
                                }
                                return null;
                              },
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 16, color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    icon: isDisplayKeyboard
                                        ? Icon(
                                            _isObscured
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.white)
                                        : const Visibility(
                                            visible: false,
                                            child: Icon(Icons.visibility_off)),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured = !_isObscured;
                                      });
                                    },
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70))),
                            ),
                            const SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                debugPrint("Test login");
                                try {
                                  if (_fromKey.currentState!.validate()) {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: _userEmailController.text,
                                            password: _passwordController.text)
                                        .then((value) {
                                      Navigator.of(context).pushReplacement(
                                          PageTransition(
                                              child: const ScHome(),
                                              type: PageTransitionType
                                                  .rightToLeft));
                                    }).onError((error, stackTrace) {
                                      debugPrint("Error ${error}");
                                    });
                                  } else {
                                    debugPrint("Error in login button");
                                  }
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 200,
                                          width: 200,
                                          color: ColorConst.white,
                                          child: Text("${e.toString()}"),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Container(
                                  height: 51,
                                  width: 320,
                                  decoration: BoxDecoration(
                                      color: ColorConst.pink,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Text("LOGIN",
                                        style: GoogleFonts.nunito(
                                            fontSize: 16, color: Colors.white)),
                                  )),
                            ),
                            const SizedBox(height: 90),

                                Padding(
                                  padding: const EdgeInsets.only(top: 9.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don't have an account? ",
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: Colors.white)),
                                      InkWell(
                                        onTap: () {
                                          debugPrint("Test sign up");
                                          Navigator.of(context).push(
                                              PageTransition(
                                                  child: Sc2Signup(),
                                                  type: PageTransitionType
                                                      .bottomToTop));
                                        },
                                        child: Text("Sign up",
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: ColorConst.pink)),
                                      )
                                    ],
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
