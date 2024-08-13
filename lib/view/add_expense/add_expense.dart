import 'dart:developer';

import 'package:expense_tracker/controller/homepage_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/view/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  final bool isEdit;
  final editKey;
  const AddExpense({super.key, required this.isEdit, this.editKey});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController amount_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  String? selectedName;
  String? selectedType;

  final _formKey = GlobalKey<FormState>();
  final List<String> name_list = [
    "travel",
    "petrol",
    "food",
  ];
  final List<String> type_list = [
    "INCOME",
    "EXPENSE",
  ];
  @override
  void initState() {
    super.initState();
    if (widget.isEdit == true) {
      final editnote = HomepageController.myBox.get(widget.editKey);
      selectedName = editnote["name"];
      selectedType = editnote["type"];
      amount_controller.text = (editnote["amount"] ?? 0).toString();
      date_controller.text = editnote["date"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavigation(
                          initialIndex: 0,
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
                widget.isEdit == true ? " Edit Expense" : "Add expense",
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
                      height: 550,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorConstants.primary_white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "TYPE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primary_black
                                        .withOpacity(.5)),
                              ),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.container_color)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.container_color)),
                                  hintText: "Type",
                                  fillColor: ColorConstants.container_color,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                value: selectedType,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedType = newValue;
                                  });
                                },
                                items: type_list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                validator: (String? value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please select type'
                                      : null;
                                },
                              ),
                              Text(
                                "NAME",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primary_black
                                        .withOpacity(.5)),
                              ),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.container_color)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.container_color)),
                                  hintText: "Name",
                                  fillColor: ColorConstants.container_color,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                value: selectedName,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedName = newValue;
                                  });
                                },
                                items: name_list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                validator: (String? value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please select name'
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "AMOUNT",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primary_black
                                        .withOpacity(.5)),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: amount_controller,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.container_color)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.container_color)),
                                  hintText: "Amount",
                                  fillColor: ColorConstants.container_color,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (String? value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter an amount'
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "DATE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primary_black
                                        .withOpacity(.5)),
                              ),
                              TextFormField(
                                controller: date_controller,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.container_color)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.container_color)),
                                  hintText: "Date",
                                  suffixIcon: Icon(
                                    Icons.calendar_month_rounded,
                                    color: ColorConstants.container_color,
                                  ),
                                  fillColor: ColorConstants.container_color,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (String? value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Please enter a date'
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: InkWell(
                                  // onTap: () {
                                  //   context
                                  //       .read<HomepageController>()
                                  //       .deleteAllNotes();
                                  // },
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await context
                                          .read<HomepageController>()
                                          .addData(
                                              name: selectedName ?? "",
                                              type: selectedType ?? "",
                                              amount: int.tryParse(
                                                      amount_controller.text) ??
                                                  0,
                                              date: date_controller.text);
                                    }
                                    context
                                        .read<HomepageController>()
                                        .total_balance(
                                            selectedType ?? "",
                                            int.tryParse(
                                                    amount_controller.text) ??
                                                0);

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigation(initialIndex: 0),
                                        ));
                                    log("added to hive");
                                  },

                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstants.container_color,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 80, vertical: 10),
                                      child: Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color:
                                                ColorConstants.primary_white),
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
      ),
    );
  }
}
