import 'package:expense_tracker/controller/homepage_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 200,
      width: 350,
      decoration: BoxDecoration(
          color: ColorConstants.container_color,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Balance",
                  style: TextStyle(
                      color: ColorConstants.primary_white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              Text(
                  HomepageController.myBox.get("totalbalance") == null
                      ? "0"
                      : "₹ " +
                          "${HomepageController.myBox.get("totalbalance")}",
                  style: TextStyle(
                      color: ColorConstants.primary_white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_down_rounded,
                        color: ColorConstants.primary_white.withOpacity(.6),
                        size: 20,
                      ),
                      Text(" Income",
                          style: TextStyle(
                            color: ColorConstants.primary_white,
                          ))
                    ],
                  ),
                  Text(
                      HomepageController.myBox.get("income") == null
                          ? "0"
                          : "₹ " + "${HomepageController.myBox.get("income")}",
                      style: TextStyle(
                          color: ColorConstants.primary_white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))
                ],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_down_rounded,
                        color: ColorConstants.primary_white.withOpacity(.6),
                        size: 20,
                      ),
                      Text(" Expense",
                          style: TextStyle(
                            color: ColorConstants.primary_white,
                          ))
                    ],
                  ),
                  Text(
                      HomepageController.myBox.get("expense") == null
                          ? "0"
                          : "₹ " + "${HomepageController.myBox.get("expense")}",
                      style: TextStyle(
                          color: ColorConstants.primary_white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
