import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:canna_drive_main/API/api.dart';
import 'package:canna_drive_main/Model/WeeklyDataModel/WeeklyDataModel.dart';
import 'package:canna_drive_main/Model/CurrentMonthModel/CurrentMonthModel.dart';
import 'package:canna_drive_main/Model/YearlyAvgModel/YearlyAvgModel.dart';

class Statistics extends StatefulWidget {
  final data;
  Statistics(this.data);
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  var presentSale;
  var presentMonthName;
  var prevMonthSale;
  var prevMonthName;
  var yearAvgSale;
  var collectionWeeklySale;
  bool _isSale = true;

  @override
  void initState() {
    _getSaleData();
    super.initState();
  }

  void _getSaleData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var driverJson = localStorage.getString('cannadrive');
    var driver = json.decode(driverJson);

    ///////////    previous sale /////////////////

    var resPrevMonth = await CallApi()
        .getData('app/driverPreviousMonthIncome/${driver['id']}');
    var collectionPrevMonthSale = json.decode(resPrevMonth.body);
    // print(collectionPrevMonthSale);

    var prevMonth = CurrentMonthModel.fromJson(collectionPrevMonthSale);
    prevMonth.total == null
        ? prevMonthSale = 0
        : prevMonthSale = prevMonth.total.toInt();

    if (prevMonth.month == 1) {
      prevMonthName = "January";
    } else if (prevMonth.month == 2) {
      prevMonthName = "February";
    } else if (prevMonth.month == 3) {
      prevMonthName = "March";
    } else if (prevMonth.month == 4) {
      prevMonthName = "April";
    } else if (prevMonth.month == 5) {
      prevMonthName = "May";
    } else if (prevMonth.month == 6) {
      prevMonthName = "June";
    } else if (prevMonth.month == 7) {
      prevMonthName = "July";
    } else if (prevMonth.month == 8) {
      prevMonthName = "August";
    } else if (prevMonth.month == 9) {
      prevMonthName = "September";
    } else if (prevMonth.month == 10) {
      prevMonthName = "October";
    } else if (prevMonth.month == 11) {
      prevMonthName = "November";
    } else if (prevMonth.month == 12) {
      prevMonthName = "December";
    }

    ///////////    current sale /////////////////

    var resCurrentSale =
        await CallApi().getData('app/driverMonthlyIncome/${driver['id']}');
    var collectionSale = json.decode(resCurrentSale.body);

    var currentMonth = CurrentMonthModel.fromJson(collectionSale);
    currentMonth.total == null
        ? presentSale = 0
        : presentSale = currentMonth.total.toInt();

    if (currentMonth.month == 1) {
      presentMonthName = "January";
    } else if (currentMonth.month == 2) {
      presentMonthName = "February";
    } else if (currentMonth.month == 3) {
      presentMonthName = "March";
    } else if (currentMonth.month == 4) {
      presentMonthName = "April";
    } else if (currentMonth.month == 5) {
      presentMonthName = "May";
    } else if (currentMonth.month == 6) {
      presentMonthName = "June";
    } else if (currentMonth.month == 7) {
      presentMonthName = "July";
    } else if (currentMonth.month == 8) {
      presentMonthName = "August";
    } else if (currentMonth.month == 9) {
      presentMonthName = "September";
    } else if (currentMonth.month == 10) {
      presentMonthName = "October";
    } else if (currentMonth.month == 11) {
      presentMonthName = "November";
    } else if (currentMonth.month == 12) {
      presentMonthName = "December";
    }

    //////////////////  Yearly Average/////////////////

    var resYearlyAvg = await CallApi()
        .getData('app/driverYearlyAverageIncome/${driver['id']}');
    var collectionYearlyAvgSale = json.decode(resYearlyAvg.body);

    for (var d in collectionYearlyAvgSale) {
      var yearlyAvg = YearlyAvgModel.fromJson(d);
      yearlyAvg.avg == null
          ? yearAvgSale = 0
          : yearAvgSale = yearlyAvg.avg.toInt();
    }

    print("prevMonth.month");
    print(yearAvgSale);
    //////////////////  Weekly Sale /////////////////

    var resWeeklySale =
        await CallApi().getData('app/driverWeeklyIncome/${driver['id']}');
    collectionWeeklySale = json.decode(resWeeklySale.body);

    print("week");
    print(collectionWeeklySale);

    if (!mounted) return;
    setState(() {
      _isSale = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dataBarChart = [
      Sales(
        prevMonthName,
        prevMonthSale,
      ),
    ];

    var dataBarChart2 = [
      Sales(
        presentMonthName,
        presentSale,
      ),
    ];

    var dataBarChart3 = [
      Sales('             Average', yearAvgSale),
    ];

    ////////  stack bar edit shesh
    var series = [
      charts.Series(

          //radiusPxFn: (Sales sales, _) =>100,
          strokeWidthPxFn: (Sales sales, _) => 2,
          domainFn: (Sales sales, _) => sales.states,
          measureFn: (Sales sales, _) => sales.amount,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          id: 'Earnings',
          data: dataBarChart),
      charts.Series(
        strokeWidthPxFn: (Sales sales, _) => 2,
        domainFn: (Sales sales, _) => sales.states,
        measureFn: (Sales sales, _) => sales.amount,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        id: 'Earnings2',
        data: dataBarChart2,
      ),
      charts.Series(
          strokeWidthPxFn: (Sales sales, _) => 2,
          domainFn: (Sales sales, _) => sales.states,
          measureFn: (Sales sales, _) => sales.amount,
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          id: 'Earnings3',
          data: dataBarChart3),
    ];
    // var linechart = charts.TimeSeriesChart(
    //   timechart,
    //   defaultRenderer: charts.LineRendererConfig(
    //     radiusPx: 4.0
    //   ),
    // );
    var chart = charts.BarChart(
      series,
      barGroupingType: charts.BarGroupingType.stacked,
      barRendererDecorator: charts.BarLabelDecorator(
          labelPosition: charts.BarLabelPosition.outside,
          labelAnchor: charts.BarLabelAnchor.end,
          labelPadding: 10),
      domainAxis: charts.OrdinalAxisSpec(
          //renderSpec:
          //tickProviderSpec: true
          ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(

              // Tick and Label styling here.
              axisLineStyle: charts.LineStyleSpec(),
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 8, // size in Pts.
                  color: charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                thickness: 1,
                //color: Colors.amber
              ))),
      defaultRenderer: new charts.BarRendererConfig(
          // minBarLengthPx: 5,

          // stackHorizontalSeparator: 10,
          // barRendererDecorator: ,
          // weightPattern: [1, 1, 1],
          // groupingType: charts.BarGroupingType.,
          strokeWidthPx: 10.0,
          cornerStrategy: charts.ConstCornerStrategy(10)),
    );
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF01d56a),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          backgroundColor: Colors.white,
          //   elevation: 0,
          title: Text(
            "Statistics",
            style: TextStyle(
              color: Color(0xFF01d56a),
            ),
          )),
      body: widget.data == 0
          ? Center(
              child: Container(
                  margin: EdgeInsets.all(8),
                  child: Text(
                    "You have no data to show",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
            )
          : _isSale
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(

                      // height: 700,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 20, bottom: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 0.2,
                               shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
                              margin: EdgeInsets.only(
                                  bottom: 8, top: 10, left: 20, right: 20),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 16.0,
                                        // offset: Offset(0.0,3.0)
                                      )
                                    ],
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Column(children: [
                                    Container(
                                        margin: EdgeInsets.all(8),
                                        child: Text(
                                          'Total Sales',
                                          style: TextStyle(
                                              color: Color(0xFF343434),
                                              fontSize: 18),
                                        )),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 190.0,
                                      child: chart,
                                    )
                                  ])),
                            ),
                            collectionWeeklySale.length < 1
                                ? Container(
                                    margin: EdgeInsets.only(top: 70),
                                    child: Text(
                                      'You didn\'t receive any order last week',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 17),
                                    ))
                                : Container(
                                    child: Card(
                                       shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
                                      elevation: 0.2,
                                      margin: EdgeInsets.only(
                                          bottom: 8,
                                          top: 10,
                                          left: 20,
                                          right: 20),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[200],
                                              blurRadius: 16.0,
                                              // offset: Offset(0.0,3.0)
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 8, top: 10),
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Weekly Sales',
                                                  style: TextStyle(
                                                      color: Color(0xFF343434),
                                                      fontSize: 18),
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 12,
                                                    right: 12),
                                                height: 220.0,
                                                child: SimpleTimeSeriesChart(
                                                    collectionWeeklySale)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ])),
                ),
    );
  }
}

class Sales {
  final String states;
  final int amount;

  Sales(this.states, this.amount);
}

class LinearSales {
  final String day;
  final int sales;

  LinearSales(this.day, this.sales);
}

class SimpleTimeSeriesChart extends StatefulWidget {
  final data;
  SimpleTimeSeriesChart(this.data);
  @override
  _SimpleTimeSeriesChartState createState() => _SimpleTimeSeriesChartState();
}

class _SimpleTimeSeriesChartState extends State<SimpleTimeSeriesChart> {
  var week;

  @override
  Widget build(BuildContext context) {
    return //_isLoading?Center(child: CircularProgressIndicator(),):
        charts.TimeSeriesChart(
      _createSampleData(),
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(

              // Tick and Label styling here.
              axisLineStyle: charts.LineStyleSpec(),
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 8, // size in Pts.
                  color: charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(

                  //color: charts.MaterialPalette.black
                  ))),
      animate: false,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        showAxisLine: true,
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'EEE',
            transitionFormat: 'EEE',
          ),
        ),
      ),
    );
  }

  List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    List<TimeSeriesSales> data = <TimeSeriesSales>[];

    for (var d in widget.data) {
      week = WeeklyDataModel.fromJson(d);

      data.add(
        TimeSeriesSales(
            DateTime(week.year, week.month, week.day), week.total.toInt()),
      );
    }

    return <charts.Series<TimeSeriesSales, DateTime>>[
      charts.Series<TimeSeriesSales, DateTime>(
        strokeWidthPxFn: (_, __) => 3.0,
        insideLabelStyleAccessorFn: (_, __) => charts.TextStyleSpec(
            color: charts.MaterialPalette.red.shadeDefault, fontSize: 10),
        id: 'Sales',
        //ino color change kora jay bar or
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class TimeSeriesSales {
  TimeSeriesSales(this.time, this.sales);

  final DateTime time;
  final int sales;
}
