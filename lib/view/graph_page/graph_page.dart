import 'dart:developer';

import 'package:expense_tracker/controller/homepage_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/view/graph_page/widgets/custom_graph_widget.dart';
import 'package:expense_tracker/view/homepage/widgets/transcaion_card.dart';
import 'package:flutter/material.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List type = ["INCOME", "EXPENSE"];
  String selectedType = "INCOME";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Icon(Icons.arrow_back_ios_new_outlined),
            title: Text(
              "Statistics",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      color: ColorConstants.background_color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Day",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.primary_white),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      color: ColorConstants.background_color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Week",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.primary_white),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      color: ColorConstants.background_color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Month",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.primary_white),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      color: ColorConstants.background_color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Year",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.primary_white),
                    ),
                  ),
                )
              ],
            ),
          ),

          // add graph

          SliverToBoxAdapter(
            child: Column(
              children: [
                DropdownButton(
                  items: type
                      .map(
                        (types) => DropdownMenuItem<String>(
                            value: types, child: Text(types)),
                      )
                      .toList(),
                  onChanged: (value) => setState(() {
                    selectedType;
                  }),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomGraphWidget(),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Spending",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Icon(Icons.sort)
                ],
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) {
              final currentKey = HomepageController.keyList[index];
              dynamic currentElement = HomepageController.myBox.get(currentKey);
              if (currentElement is Map) {
                return TranscaionCard(
                  index: index,
                  amount: currentElement["amount"] ?? "",
                  date: currentElement["date"] ?? "",
                  name: currentElement["name"] ?? "",
                  type: currentElement["type"] ?? "",
                  imageIndex: currentElement["imageIndex"],
                );
              } else {
                log(" map errror");
              }
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: HomepageController.keyList.length,
          )
        ],
      ),
    );
  }
}
