import 'package:expense_tracker/core/constants/color_constants.dart';
import 'package:expense_tracker/view/add_expense/add_expense.dart';
import 'package:expense_tracker/view/graph_page/graph_page.dart';
import 'package:expense_tracker/view/homepage/homepage.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  const BottomNavigation({super.key, required this.initialIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  List screenlist = [
    Homepage(),
    AddExpense(
      isEdit: false,
    ),
    GraphPage()
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenlist[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          fixedColor: const Color.fromARGB(255, 21, 120, 113),
          unselectedItemColor: ColorConstants.background_color.withOpacity(.5),
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
              label: "Add",
              icon: Icon(
                Icons.add,
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up), label: "Graph"),
          ]),
    );
  }
}
