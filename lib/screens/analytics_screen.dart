import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/validate_analytics_form/analytics_form_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/submit_form/submit_form_bloc.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';
import 'package:nutrition_tracker/widgets/CustomNavigationBar.dart';
import 'package:pie_chart/pie_chart.dart';

Map<String, double> dataMap = {
  "Carboidrati": 50,
  "Proteine": 35,
  "Grassi": 25,
};

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return CupertinoPageScaffold(
      navigationBar: const CustomNavigationBar(
        navigationBar: CupertinoNavigationBar(),
        title: 'Analytics',
      ),
      child: ListView(
        children: [
          _dailyCalories(context),
          BlocBuilder<SubmitFormBloc, SubmitFormState>(
            builder: (context, state) {
              return state.tdee != null ? _btnUseTdee(context) : Container();
            },
          ),
          BlocBuilder<AnalyticsFormBloc, AnalyticsFormState>(
            builder: (context, state) {
              return _pieChart(context, state);
            },
          ),
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
              child: BlocBuilder<AnalyticsFormBloc, AnalyticsFormState>(
                builder: (context, state) {
                  return Text(
                    state.tdee != null ? "${state.tdee} kcal" : 'Nessun dato',
                    style: const TextStyle(fontSize: 25),
                  );
                },
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

  Widget _btnUseTdee(BuildContext context) => CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        children: [
          CupertinoListTile(
            padding: EdgeInsets.zero,
            title: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Usa il TDEE calcolato',
                  style: TextStyle(
                      color: CupertinoTheme.of(context).primaryColor,
                      fontSize: 16),
                )),
            onTap: () {
              context.read<AnalyticsFormBloc>().add(ChangeTdeeValueFromProfile(
                  tdee: context.read<SubmitFormBloc>().state.tdee,
                  percentageCarbs: 45.0,
                  percentagePro: 30.0,
                  percentageFat: 25.0));
            },
          ),
        ],
      );

  Widget _pieChart(BuildContext context, AnalyticsFormState state) =>
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
                  dataMap: state.dataChart ?? dataMap,
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

  Widget _legendsValuesPieChart(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Carboidrati",
                    style: TextStyle(color: CustomColors.pinkPieChart),
                  ),
                  BlocBuilder<AnalyticsFormBloc, AnalyticsFormState>(
                    builder: (context, state) {
                      return Text(
                        state.carbs != null ? '${state.carbs} g' : '-',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.pinkPieChart),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text("Proteine",
                      style: TextStyle(color: CustomColors.bluePieChart)),
                  BlocBuilder<AnalyticsFormBloc, AnalyticsFormState>(
                    builder: (context, state) {
                      return Text(
                          state.protein != null ? '${state.protein} g' : '-',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.bluePieChart));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text("Grassi",
                      style: TextStyle(color: CustomColors.orangePieChart)),
                  BlocBuilder<AnalyticsFormBloc, AnalyticsFormState>(
                    builder: (context, state) {
                      return Text(state.fat != null ? '${state.fat} g' : '-',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.orangePieChart));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
