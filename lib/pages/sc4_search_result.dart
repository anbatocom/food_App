import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:food_app_example/pages/sc4_gridmain.dart';
import 'package:food_app_example/pages/sc4_listmain.dart';

import 'package:food_app_example/widgets/custom_appbar1.dart';

class Sc4SearchResult extends StatefulWidget {
  final String resultSearch;
  const Sc4SearchResult({Key? key, required this.resultSearch})
      : super(key: key);

  @override
  _Sc4SearchResultState createState() => _Sc4SearchResultState();
}

class _Sc4SearchResultState extends State<Sc4SearchResult> {
  bool isGridMode = false;
  late String result = widget.resultSearch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar1(
          onToggle: (bool isGrid) {
            setState(() {
              isGridMode = isGrid;
            });
          },
          isGridMode: isGridMode,
          result: result,
          onSearch: (String resultValue) {
            setState(() {
              debugPrint(result);
              result = resultValue;
            });
          },
          setEmpty: () {
            setState(() {
              result = "";
            });
          },
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("items")
                .doc("WiJt2PpANxyiRPar3kKU")
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return Text("Không có dữ liệu");
              } else {
                List<dynamic> itemsData = snapshot.data!['items'];
                List<dynamic> filteredItems = itemsData.where((item) {
                  String realResult = (result == widget.resultSearch)
                      ? widget.resultSearch
                      : result;
                  return item['title'] == realResult;
                }).toList();

                return SafeArea(
                  child: isGridMode
                      ? GridMain(
                          items: result.isEmpty ? itemsData : filteredItems)
                      : ListMain(
                          items: result.isEmpty ? itemsData : filteredItems),
                );
              }
            }));
  }
}
