import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';
import 'package:nutrition_tracker/widgets/CustomNavigationBar.dart';
import 'package:pie_chart/pie_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Carboidrati": 5,
      "Proteine": 3,
      "Grassi": 2,
    };

    return CupertinoPageScaffold(
      navigationBar: const CustomNavigationBar(navigationBar: CupertinoNavigationBar(), title: 'Analytics',),
      child: ListView(
        children: [
          _dailyCalories(context),
          _pieChart(context, dataMap),
        ],
      ),
    );
  }

  Widget _dailyCalories(BuildContext context) =>
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        header: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text('Requisito calorico giornaliero'),
        ),
        children: [
          CupertinoListTile(
            title: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "1900 kcal",
                style: TextStyle(fontSize: 25),
              ),
            ),
            trailing: const Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {},
          ),
        ],
      );

  Widget _pieChart(BuildContext context, dataMap) =>
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        header: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text('Distribuzione dei Macronutrienti'),
        ),
        children: [
          Column(
            children: [
              _legendsValuesPieChart(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PieChart(
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: false,
                      chartValueStyle:
                          TextStyle(color: CustomColors.textColor)),
                  chartLegendSpacing: 20,
                  dataMap: dataMap,
                  chartRadius: MediaQuery.of(context).size.width * 0.4,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.bottom,
                  ),
                  colorList: const [
                    CustomColors.pinkPieChart,
                    CustomColors.bluePieChart,
                    CustomColors.orangePieChart
                  ],
                ),
              ),
            ],
          )
        ],
      );

  Widget _legendsValuesPieChart(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Carboidrati",
                    style: TextStyle(color: CustomColors.pinkPieChart),
                  ),
                  Text(
                    '190g',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.pinkPieChart),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text("Proteine",
                      style: TextStyle(color: CustomColors.bluePieChart)),
                  Text('147 g',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.bluePieChart)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text("Grassi",
                      style: TextStyle(color: CustomColors.orangePieChart)),
                  Text('61 g',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.orangePieChart)),
                ],
              ),
            ),
          ],
        ),
  );
}
