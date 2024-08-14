import 'dart:developer';

import 'package:expense_tracker/controller/homepage_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/view/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final bool value;
  const CategoryCard({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    log("value of---- $value");
    TextEditingController category_controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigation(
                        initialIndex: 1,
                      ),
                    ));
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorConstants.primary_white,
              ),
            ),
            backgroundColor: ColorConstants.background_color,
            title: Text(
              value == true ? "Add Income Category" : "Add Expense Category",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.primary_white),
            ),
            expandedHeight: 50,
          ),
          SliverToBoxAdapter(
            child: Stack(children: [
              Column(children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: ColorConstants.background_color,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                ),
                Container(
                  height: 500,
                  color: Colors.white,
                ),
              ]),
              Positioned(
                  top: 30,
                  right: 20,
                  left: 20,
                  child: Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorConstants.primary_white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CATEGORY",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.primary_black
                                          .withOpacity(.5)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: category_controller,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants
                                                .container_color)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants
                                                .container_color)),
                                    hintText: "Category",
                                    fillColor: ColorConstants.container_color,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    return (value == null || value.isEmpty)
                                        ? 'Please enter an category'
                                        : null;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (value == true) {
                                      HomepageController.income_list
                                          .add(category_controller.text);
                                      context
                                          .read<HomepageController>()
                                          .saveIncomeList();
                                      log("category list---${HomepageController.income_list}");
                                      Navigator.pop(context);
                                    } else {
                                      HomepageController.expense_list
                                          .add(category_controller.text);
                                      log("category list---${HomepageController.expense_list}");
                                      context
                                          .read<HomepageController>()
                                          .saveIncomeList();
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstants.container_color,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 10),
                                    child: Text(
                                      "SUBMIT",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: ColorConstants.primary_white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
            ]),
          ),
        ],
      ),
    );
  }
}
