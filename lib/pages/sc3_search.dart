import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/img_asset.dart';
import 'package:food_app_example/pages/sc4_search_result.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Sc3Search extends StatefulWidget {
  const Sc3Search({Key? key}) : super(key: key);

  @override
  _Sc3SearchState createState() => _Sc3SearchState();
}

class _Sc3SearchState extends State<Sc3Search> {
  TextEditingController _controller = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(currentUser?.displayName);
    debugPrint(currentUser?.email);
    debugPrint(currentUser?.uid);
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
                image: AssetImage(ImgAsset.BgSearch), fit: BoxFit.cover),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 26, top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: const DecorationImage(
                                  image: AssetImage(ImgAsset.Avatar),
                                  fit: BoxFit.cover)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Hi, ${currentUser?.displayName}",
                            style: GoogleFonts.robotoFlex(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 24, bottom: 60, right: 70),
                    child: Text(
                      "What can\nwe serve you\ntoday?",
                      style: GoogleFonts.roboto(
                        color: ColorConst.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                      strutStyle: const StrutStyle(leading: 3),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    child: Form(
                      key: _fromKey,
                      child: TextFormField(
                          controller: _controller,
                          validator: (value) {
                            if (_controller.text.isEmpty) {
                              return "Bạn phải nhập thông tin ở đây";
                            }
                            return null;
                          },
                          style: GoogleFonts.nunito(
                              color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Search for address food...",
                            hintStyle: GoogleFonts.nunito(
                                color: ColorConst.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                )),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 200,
                                            width: 300,
                                            color: ColorConst.white,
                                            child: ListView.separated(
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Text("Viet Nam");
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  height: 1,
                                                  color: ColorConst.grey,
                                                );
                                              },
                                              itemCount: 10,
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.location_on,
                                  color: ColorConst.pink,
                                )),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    const BorderSide(color: ColorConst.pink)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                          )),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5, left: 25, right: 25, bottom: 100),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_fromKey.currentState!.validate()) {
                          await Navigator.of(context).push(PageTransition(
                            child:
                                Sc4SearchResult(resultSearch: _controller.text),
                            type: PageTransitionType.theme,
                          ));
                          _controller.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConst.pink,
                          fixedSize: const Size(360, 51)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SEARCH",
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
