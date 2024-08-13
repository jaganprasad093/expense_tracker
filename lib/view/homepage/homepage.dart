import 'dart:developer';

import 'package:expense_tracker/controller/homepage_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/view/homepage/widgets/expense_card.dart';
import 'package:expense_tracker/view/homepage/widgets/transcaion_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    //  context.read<HomepageController>().
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   backgroundColor: ColorConstants.background_color,
          //   leading: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "Good afternoon,",
          //         style: TextStyle(
          //             color: ColorConstants.primary_white,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         "Name",
          //         style: TextStyle(
          //             color: ColorConstants.primary_white,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          //   leadingWidth: 200,
          //   expandedHeight: 50,
          // ),
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              color: ColorConstants.background_color,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text("Good Morning ,",
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: ColorConstants.primary_white,
                                fontSize: 15)),
                        Text(
                          "Vasu Annan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.primary_white,
                              fontSize: 25),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorConstants.primary_white.withOpacity(.1)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.notification_important_outlined,
                          color: ColorConstants.primary_white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(children: [
              Column(children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                      color: ColorConstants.background_color,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                ),
                Container(
                  height: 100,
                  color: Colors.white,
                ),
              ]),
              Positioned(right: 20, child: ExpenseCard())
            ]),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transction and history",
                        style: TextStyle(
                          color: ColorConstants.primary_black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("See all",
                          style: TextStyle(
                            color: ColorConstants.primary_black.withOpacity(.6),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          SliverList.separated(
              itemBuilder: (context, index) {
                final currentKey = HomepageController.keyList[index];
                dynamic currentElement =
                    HomepageController.myBox.get(currentKey);
                log("current element:$currentElement");

                if (currentElement is Map) {
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete),
                    ),
                    key: ValueKey<int>(HomepageController.keyList[index]),
                    onDismissed: (DismissDirection direction) {
                      context
                          .read<HomepageController>()
                          .delete(HomepageController.keyList[index]);
                      log("deleted");
                    },
                    child: TranscaionCard(
                      amount: currentElement["amount"],
                      date: currentElement["date"] ?? "",
                      name: currentElement["name"] ?? "",
                      type: currentElement["type"] ?? "",
                      index: index,
                    ),
                  );
                } else {
                  log("error -- it not map");
                }
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
              itemCount: HomepageController.keyList.length)
        ],
      ),
    );
  }
}
