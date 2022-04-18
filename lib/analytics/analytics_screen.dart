import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/analytics/month_report.dart';
import 'package:seller/analytics/week_report.dart';
import 'package:seller/control/controller.dart';

import 'day_report.dart';

class AnalyticScreen extends StatelessWidget {
  const AnalyticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Controller _tabs = Get.put(Controller());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Day',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    'Week',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    'Month',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(children: [DayReport(), WeekReport(), MonthReport()]),
      ),
    );
  }
}
