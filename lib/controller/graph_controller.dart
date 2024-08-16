import 'dart:developer';
import 'package:expense_tracker/controller/homepage_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphController with ChangeNotifier {
  static List<FlSpot> spots = [];

  void loadData(String type) {
    spots.clear();
    List<FlSpot> spots2 = [];
    List<FlSpot> spots3 = [];

    HomepageController.keyList.forEach((key) {
      var data = HomepageController.myBox.get(key);
      log("type---$type");
      DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(data['date']);
      int month = parsedDate.month - 1;

      if (type == 'EXPENSE') {
        try {
          // DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(data['date']);
          // int month = parsedDate.month - 1;
          // log("month---${month}");
          double amount = data['amount'].toDouble();
          spots2.add(FlSpot(month.toDouble(), amount));
          log("first loop spot2---$spots2");
        } catch (e) {
          log('Error  date1: $e');
        }
        return;
      } else if (type == 'INCOME') {
        try {
          log("month---${month}");
          double amount = data['amount'].toDouble();
          spots3.add(FlSpot(month.toDouble(), amount));
          log("spot3---$spots3");
        } catch (e) {
          log('Error  date2: $e');
        }
        return;
      }
    });

    if (type == 'EXPENSE') {
      spots.addAll(spots2);
    } else if (type == 'INCOME') {
      spots.addAll(spots3);
    }

    log("spots--$spots");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
