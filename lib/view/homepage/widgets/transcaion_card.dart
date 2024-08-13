import 'dart:developer';
import 'package:expense_tracker/controller/homepage_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/view/add_expense/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranscaionCard extends StatelessWidget {
  final String name;
  final String date;
  final int amount;
  final String type;
  int index;

  TranscaionCard(
      {super.key,
      required this.name,
      required this.date,
      required this.amount,
      required this.index,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(children: [
                CircleAvatar(
                  radius: 28,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                        onTap: () {
                          final currentKey = HomepageController.keyList[index];
                          final currentElement =
                              HomepageController.myBox.get(currentKey);
                          if (currentElement != null) {
                            context.read<HomepageController>().editList(
                                name: currentElement["name"],
                                date: currentElement["date"],
                                amount: currentElement["amount"],
                                type: currentElement["type"],
                                key: currentKey);
                            log("key---$currentKey");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddExpense(
                                    isEdit: true,
                                    editKey: currentKey,
                                  ),
                                ));
                          }
                        },
                        child: Icon(Icons.edit)))
              ]),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          color: ColorConstants.primary_black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Text(date,
                      style: TextStyle(
                        color: ColorConstants.primary_black.withOpacity(.5),
                      ))
                ],
              ),
            ],
          ),
          Text(type == "INCOME" ? "+ ₹ " + "$amount" : "- ₹ " + "$amount",
              style: TextStyle(
                  fontSize: 20,
                  color: type == "INCOME" ? ColorConstants.green : Colors.red,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
