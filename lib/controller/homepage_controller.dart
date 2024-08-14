import 'dart:developer';
import 'package:expense_tracker/core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomepageController with ChangeNotifier {
  static late Box myBox;

  static List keyList = [];
  int income = 0;
  int expense = 0;
  int totalbalance = 0;
  static List<String> expense_list = [
    "travel",
    "petrol",
    "food",
  ];
  static List<String> income_list = ["salary", "tip"];
  static List expense_imageList = [
    ImageConstants.food,
    ImageConstants.travel,
    ImageConstants.petrol,
  ];
  static List income_imagelist = [
    ImageConstants.freelanace,
    ImageConstants.salary,
    ImageConstants.tip,
  ];
  Future<void> initialize() async {
    myBox = await Hive.openBox('MyBox');
    income = myBox.get('income', defaultValue: 0);
    expense = myBox.get('expense', defaultValue: 0);
    totalbalance = myBox.get('totalbalance', defaultValue: 0);
    expense_list =
        myBox.get('expense_list', defaultValue: ["travel", "petrol", "food"]);
    income_list = myBox.get('income_list', defaultValue: ["salary", "tip"]);

    log("Loaded income: $income");
    log("Loaded expense: $expense");
    log("Loaded totalbalance: $totalbalance");
    log("expense list: $expense_list");
    log("income list: $income_list");

    keyList = myBox.keys.toList();
  }

  Future<void> addData({
    required String name,
    required String type,
    required int amount,
    required String date,
    required String description,
    int imageIndex = 0,
  }) async {
    if (!myBox.isOpen) {
      await initialize();
    }
    await myBox.add({
      "name": name,
      "date": date,
      "amount": amount,
      "imageIndex": imageIndex,
      "description": description,
      "type": type,
    });
    keyList = myBox.keys.toList();

    notifyListeners();
  }

  void total_balance(String type, int amount) {
    if (type == "INCOME") {
      income += amount;
      log("income---$income");
    } else {
      expense += amount;
      log("expense---$expense");
    }
    totalbalance = income - expense;
    log("total balance---$totalbalance");

    myBox.put('income', income);
    myBox.put('expense', expense);
    myBox.put('totalbalance', totalbalance);
    log("Saved data to Hive: income=$income, expense=$expense, totalbalance=$totalbalance");

    notifyListeners();
  }

// delete function
  Future<void> delete(var key, String type, int amount) async {
    if (type == "INCOME") {
      income -= amount;
      log("income---$income");
    } else {
      expense -= amount;
      log("expense---$expense");
    }
    totalbalance = income - expense;
    log("total balance---$totalbalance");

    myBox.put('income', income);
    myBox.put('expense', expense);
    myBox.put('totalbalance', totalbalance);

    await myBox.delete(key);
    keyList = myBox.keys.toList();
    notifyListeners();
  }

  Future<void> deleteAllNotes() async {
    await myBox.clear();
    keyList = [];
    notifyListeners();
  }

  //edit function

  Future<void> editList({
    required String name,
    required String date,
    required int amount,
    required String type,
    required var key,
    int imageIndex = 0,
  }) async {
    if (myBox.containsKey(key)) {
      await myBox.put(key, {
        "name": name,
        "date": date,
        "amount": amount,
        "type": type,
      });
    } else {
      log("Key does not exist-----");
    }
  }

  // adding data to list
  saveExpenseList() {
    myBox.put('expense_list', expense_list);
    log("Saved expense_list: $expense_list");
  }

  saveIncomeList() {
    myBox.put('income_list', income_list);
    log("Saved income_list: $income_list");
  }
}
