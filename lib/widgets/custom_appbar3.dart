import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_example/const/color_const.dart';
import 'package:food_app_example/const/svg_asset.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class CustomAppbar3 extends StatefulWidget implements PreferredSizeWidget {
  final Function(DateTime) onSetDateTimeOrder;
  final Function(String) onSetTimeOrder;
  const CustomAppbar3(
      {Key? key,
      required this.onSetDateTimeOrder,
      required this.onSetTimeOrder})
      : super(key: key);

  @override
  _CustomAppbar3State createState() => _CustomAppbar3State();

  @override
  Size get preferredSize => const Size(double.infinity, 300);
}

class _CustomAppbar3State extends State<CustomAppbar3> {
  DateTime _selectedDay = DateTime.now();

  int? _currentSelectTime = 0;

  final List<TimeOfDay> _listTime = [
    const TimeOfDay(hour: 8, minute: 30),
    const TimeOfDay(hour: 9, minute: 30),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 11, minute: 30),
    const TimeOfDay(hour: 12, minute: 30),
    const TimeOfDay(hour: 15, minute: 30),
    const TimeOfDay(hour: 16, minute: 30),
    const TimeOfDay(hour: 17, minute: 30),
  ];
  // Restaurant? _restaurantInfo;
  // void setRestaurantInfo(Restaurant restaurantInfo) {
  //   setState(() {
  //     _restaurantInfo = restaurantInfo;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 230,
        color: const Color(0xFFFCF9F9),
        child: Column(children: [
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: SvgPicture.asset(
                      SvgAsset.IG_PLUS,
                      height: 50,
                      width: 50,
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Book a table".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Opacity(
                  opacity: 0.0,
                  child: SizedBox(width: 50),
                )
              ],
            ),
          ),
          Column(
            children: [
              WeeklyDatePicker(
                selectedDay: _selectedDay,
                changeDay: (value) => setState(() {
                  _selectedDay = value;
                  widget.onSetDateTimeOrder(_selectedDay);
                }),
                enableWeeknumberText: false,
                backgroundColor: const Color(0xFFFCF9F9),
                weekdayTextColor: ColorConst.black,
                digitsColor: ColorConst.black,
                selectedBackgroundColor: ColorConst.pink,
                weekdays: const ["M", "T", "W", "Th", "F", "Sa", "Su"],
                daysInWeek: 7,
              )
            ],
          ),
          const Divider(
            color: ColorConst.black,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _listTime.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        debugPrint("Time test $index");
                        setState(() {
                          _currentSelectTime = index;
                          widget.onSetTimeOrder(
                              "${_listTime[index].hour}:${_listTime[index].minute}");
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: _currentSelectTime == index
                                  ? ColorConst.pink
                                  : const Color(0xFFFCF9F9),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${_listTime[index].hour}:${_listTime[index].minute}",
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: _currentSelectTime == index
                                      ? ColorConst.white
                                      : ColorConst.greyBold,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
