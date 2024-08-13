import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomepageController with ChangeNotifier {
  static late Box myBox;

  static List keyList = [];
  int income = 0;
  int expense = 0;
  int totalbalance = 0;

  Future<void> initialize() async {
    myBox = await Hive.openBox('MyBox');
    income = myBox.get('income', defaultValue: 0);
    expense = myBox.get('expense', defaultValue: 0);
    totalbalance = myBox.get('totalbalance', defaultValue: 0);

    log("Loaded income: $income");
    log("Loaded expense: $expense");
    log("Loaded totalbalance: $totalbalance");

    keyList = myBox.keys.toList();
  }

  Future<void> addData({
    required String name,
    required String type,
    required int amount,
    required String date,
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
  Future<void> delete(var key) async {
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
}
