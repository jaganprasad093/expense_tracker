import 'package:expense_tracker/controller/graph_controller.dart';
import 'package:expense_tracker/core/constants/color_constants.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomGraphWidget extends StatefulWidget {
  const CustomGraphWidget({super.key});

  @override
  State<CustomGraphWidget> createState() => _CustomGraphWidgetState();
}

class _CustomGraphWidgetState extends State<CustomGraphWidget> {
  @override
  void initState() {
    super.initState();
    // context.read<GraphController>().loadData("INCOME");
  }

  // void loadData() {
  //   List<FlSpot> spots2 = [];

  //   HomepageController.keyList.forEach((key) {
  //     var data = HomepageController.myBox.get(key);
  //     log("data---$data");

  //     if (data is Map && data['type'] == 'EXPENSE') {
  //       try {
  //         DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(data['date']);
  //         int month = parsedDate.month - 1;
  //         log("month---${month}");
  //         double amount = data['amount'].toDouble();
  //         spots2.add(FlSpot(month.toDouble(), amount));
  //         log("spot2---$spots2");
  //       } catch (e) {
  //         log('Error  date: $e');
  //       }
  //     } else {
  //       log('data error');
  //     }
  //   });

  //   setState(() {
  //     spots = spots2;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: AspectRatio(
        aspectRatio: 2,
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                drawBelowEverything: true,
                sideTitles: SideTitles(
                  showTitles: false,
                  // getTitlesWidget: (value, meta) {
                  //   return Text(" ${(value * 1000).toInt()}");
                  // },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('Jan',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 1:
                        return Text('Feb',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 2:
                        return Text('Mar',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 3:
                        return Text('Apr',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 4:
                        return Text('May',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 5:
                        return Text('Jun',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 6:
                        return Text('Jul',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 7:
                        return Text('Aug',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 8:
                        return Text('Sep',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 9:
                        return Text('Oct',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 10:
                        return Text('Nov',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      case 11:
                        return Text('Dec',
                            style: TextStyle(
                                color: ColorConstants.primary_black
                                    .withOpacity(.5)));
                      default:
                        return Text('');
                    }
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.transparent),
                top: BorderSide(color: Colors.transparent),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: GraphController.spots,
                isCurved: true,
                barWidth: 2,
                belowBarData: BarAreaData(
                  show: true,
                  color: ColorConstants.background_color.withOpacity(.3),
                ),
              ),
            ],
            // minY: 0,
            // maxY: 10,
          ),
        ),
      ),
    );
  }
}
