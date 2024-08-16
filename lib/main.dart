import 'package:expense_tracker/controller/graph_controller.dart';
import 'package:expense_tracker/controller/homepage_controller.dart';
import 'package:expense_tracker/view/add_expense/add_expense.dart';
import 'package:expense_tracker/view/bottom_navigation/bottom_navigation.dart';
import 'package:expense_tracker/view/graph_page/graph_page.dart';
import 'package:expense_tracker/view/homepage/homepage.dart';
import 'package:expense_tracker/view/homepage/widgets/expense_card.dart';
import 'package:expense_tracker/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await HomepageController().initialize();
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomepageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GraphController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/spalsh': (context) => const SplashScreen(),
          '/homepage': (context) => const Homepage(),
          '/bottom': (context) => const BottomNavigation(
                initialIndex: 0,
              ),
          '/expense_card': (context) => const ExpenseCard(),
          '/addexpenese': (context) => const AddExpense(
                isEdit: false,
              ),
          '/graph': (context) => const GraphPage(),
        },
      ),
    );
  }
}
