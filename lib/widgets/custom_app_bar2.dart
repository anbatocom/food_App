// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/pages/sc17_settings.dart';
import 'package:page_transition/page_transition.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> icons;
  final Text title;
  const CustomAppBar2({
    Key? key,
    required this.icons,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconData? firstIconData = (icons[0] as Icon).icon;
    final IconData? secondIconData = (icons[1] as Icon).icon;
    return Container(
      width: double.infinity,
      height: 68,
      color: ColorConst.pink,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: InkWell(
                onTap: () {
                  if (firstIconData == Icons.arrow_back) {
                    debugPrint("back");
                    Navigator.of(context).pop();
                  } else if (firstIconData == Icons.search) {
                    debugPrint("search");
                  }
                },
                child: icons[0],
              ),
            ),
            Center(child: title),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  if (secondIconData == Icons.settings) {
                    debugPrint("Settings btn");
                    Navigator.of(context).push(PageTransition(
                        child: Sc17Settings(),
                        type: PageTransitionType.leftToRight));
                  }
                },
                child: icons[1],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 68);
}
