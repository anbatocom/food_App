import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/svg_asset.dart';
import 'package:food_app_example/home_cubit.dart';
import 'package:food_app_example/pages/sc13_favorites.dart';
import 'package:food_app_example/pages/sc15_order_history.dart';
import 'package:food_app_example/pages/sc3_search.dart';
import 'package:food_app_example/pages/sc8_profile.dart';
import 'package:food_app_example/widgets/colored_svg_picture.dart';

class ScHome extends StatefulWidget {
  const ScHome({Key? key}) : super(key: key);

  @override
  _ScHomeState createState() => _ScHomeState();
}

class _ScHomeState extends State<ScHome> {
  final PageController controller = PageController();
  late final HomeCubit _cubit;
  @override
  void initState() {
    _cubit = HomeCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isSelectedList = List.filled(5, false);
    return BlocProvider(
      create: (context) {
        return _cubit;
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) {
          return previous.selectedIndex != current.selectedIndex;
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: PageView(
                onPageChanged: (index) {
                  _cubit.changeTab(index);
                  for (int i = 0; i < isSelectedList.length; i++) {
                    isSelectedList[i] = (i == index);
                  }
                },
                controller: controller,
                children: [
                  Sc3Search(),
                  Sc15OrderHistory(),
                  Sc13Favorites(),
                  // Sc12Notification(),
                  Sc8Profile(
                    onIndexChanged: (index) {
                      controller.jumpToPage(index);
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.selectedIndex,
              selectedItemColor: ColorConst.pink,
              showSelectedLabels: false,
              onTap: (index) {
                _cubit.changeTab(index);
                controller.jumpToPage(index);
              },
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: ColoredSvgPicture(
                    path: SvgAsset.IG_FOOD,
                    color: ColorConst.grey,
                    isSelected: state.selectedIndex == 0,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                    icon: ColoredSvgPicture(
                      path: SvgAsset.IG_LIST_ORDER,
                      color: ColorConst.grey,
                      isSelected: state.selectedIndex == 1,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: ColoredSvgPicture(
                      path: SvgAsset.IG_FAVORITE,
                      color: ColorConst.grey,
                      isSelected: state.selectedIndex == 2,
                    ),
                    label: ""),
                // BottomNavigationBarItem(
                //     icon: ColoredSvgPicture(
                //       path: SvgAsset.IG_NOTIFICATION,
                //       color: ColorConst.grey,
                //       isSelected: state.selectedIndex == 3,
                //     ),
                //     label: ""),
                BottomNavigationBarItem(
                    icon: ColoredSvgPicture(
                      path: SvgAsset.IG_PROFILE,
                      color: ColorConst.grey,
                      isSelected: state.selectedIndex == 3,
                    ),
                    label: ""),
              ],
            ),
          );
        },
      ),
    );
  }
}
