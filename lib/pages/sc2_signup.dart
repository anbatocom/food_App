import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/models/user.dart';
import 'package:food_app_example/pages/sc2_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Sc2Signup extends StatefulWidget {
  const Sc2Signup({Key? key}) : super(key: key);

  @override
  _Sc2SignupState createState() => _Sc2SignupState();
}

class _Sc2SignupState extends State<Sc2Signup> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordControllerConfirm = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePasswordConfirm = FocusNode();
  FocusNode focusNodeUserName = FocusNode();

  bool isDisplayKeyboard = false;
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  List<bool> _isObscured = List.filled(2, false);
  bool isEmailCorrect = false;
  @override
  void initState() {
    super.initState();
    focusNodeUserName.addListener(() {
      setState(() {
        isDisplayKeyboard = focusNodeUserName.hasFocus;
      });
    });
    focusNodePassword.addListener(() {
      setState(() {
        isDisplayKeyboard = focusNodePassword.hasFocus;
      });
    });
    focusNodeEmail.addListener(() {
      setState(() {
        isDisplayKeyboard = focusNodeEmail.hasFocus;
      });
    });
    focusNodePasswordConfirm.addListener(() {
      setState(() {
        isDisplayKeyboard = focusNodePasswordConfirm.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordControllerConfirm.dispose();
    focusNodePassword.dispose();
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
                              focusNode: focusNodeUserName,
                              controller: _userNameController,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 16, color: Colors.white),
                              validator: (value) {
                                if (_userNameController.text.isEmpty) {
                                  return "Please enter your username";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "UserName",
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70))),
                            ),
                            TextFormField(
                              focusNode: focusNodeEmail,
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
                            TextFormField(
                              focusNode: focusNodePassword,
                              controller: _passwordController,
                              obscureText: !_isObscured[0],
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 16, color: Colors.white),
                              validator: (value) {
                                if (_passwordController.text.isEmpty) {
                                  return "Please enter your password";
                                }
                                if (_passwordController.text.length < 8) {
                                  return "Limit 8 characters";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    icon: isDisplayKeyboard
                                        ? Icon(
                                            _isObscured[0]
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.white)
                                        : const Visibility(
                                            visible: false,
                                            child: Icon(Icons.visibility_off)),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured[0] = !_isObscured[0];
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
                            TextFormField(
                              focusNode: focusNodePasswordConfirm,
                              controller: _passwordControllerConfirm,
                              obscureText: !_isObscured[1],
                              validator: (value) {
                                if (_passwordControllerConfirm.text.isEmpty) {
                                  return "Please enter your confirm password";
                                }
                                if (_passwordControllerConfirm.text !=
                                    _passwordController.text) {
                                  return "confirm password doesn't like password";
                                }
                                return null;
                              },
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 16, color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  suffixIcon: IconButton(
                                    icon: isDisplayKeyboard
                                        ? Icon(
                                            _isObscured[1]
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.white)
                                        : const Visibility(
                                            visible: false,
                                            child: Icon(Icons.visibility)),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured[1] = !_isObscured[1];
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
                              onTap: () async {
                                debugPrint("Test Sign up");
                                if (_fromKey.currentState!.validate()) {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _userEmailController.text,
                                          password: _passwordController.text)
                                      .then((value) async {
                                    try {
                                      String uid = value.user!.uid;
                                      debugPrint(uid);
                                      UserAccount newUser = UserAccount(
                                          userUid: uid,
                                          displayName: _userNameController.text,
                                          email: _userEmailController.text,
                                          password: _passwordController.text,
                                          imgUrl: '');
                                      value.user!.updateDisplayName(
                                          _userNameController.text);
                                      Map<String, dynamic> userJson =
                                          newUser.toJson();
                                      await FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(uid)
                                          .set({
                                        'userData': userJson,
                                      });
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Container(
                                            width: 200,
                                            height: 200,
                                            color: ColorConst.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Bạn đã đăng ký thành công",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          ColorConst.pink,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              PageTransition(
                                                                  child:
                                                                      Sc2Login(),
                                                                  type: PageTransitionType
                                                                      .rightToLeft));
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: GoogleFonts.nunito(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).onError((error, stackTrace) {
                                    debugPrint(
                                        "Error sign up with firebase ${error.toString()}");
                                  });
                                } else {
                                  debugPrint("Error in sign up");
                                }
                              },
                              child: Container(
                                  height: 51,
                                  width: 320,
                                  decoration: BoxDecoration(
                                      color: ColorConst.pink,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Text("Sign Up",
                                        style: GoogleFonts.nunito(
                                            fontSize: 16, color: Colors.white)),
                                  )),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                debugPrint("Back to login");
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  height: 51,
                                  width: 320,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Text("Back to login",
                                        style: GoogleFonts.nunito(
                                            fontSize: 16, color: Colors.white)),
                                  )),
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
