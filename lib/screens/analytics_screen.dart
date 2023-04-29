import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/submit_analytics_form/submit_analytics_form_bloc.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/validate_analytics_form/analytics_form_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/submit_form/submit_form_bloc.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';
import 'package:nutrition_tracker/widgets/CustomNavigationBar.dart';
import 'package:nutrition_tracker/widgets/analytics_bottom_sheet.dart';
import 'package:pie_chart/pie_chart.dart';

Map<String, double> dataMap = {
  "Carboidrati": 50,
  "Proteine": 25,
  "Grassi": 25,
};

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Builder(builder: (context) {
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
                  return state.tdee != null
                      ? _btnUseTdee(context)
                      : Container();
                },
              ),
              BlocBuilder<SubmitAnalyticsFormBloc, SubmitAnalyticsFormState>(
                builder: (context, state) {
                  return _pieChart(context, state);
                },
              ),
            ],
          ),
        );
      }),
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
              child: BlocBuilder<SubmitAnalyticsFormBloc,
                  SubmitAnalyticsFormState>(
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
            onTap: () {
              CupertinoScaffold.showCupertinoModalBottomSheet(
                duration: const Duration(milliseconds: 250),
                context: context,
                builder: (context) => BlocProvider<AnalyticsFormBloc>(
                  create: (context) => AnalyticsFormBloc(context.read<SubmitAnalyticsFormBloc>()),
                  child: const AnalyticsBottomSheet(),
                ),
              );
            },
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
              context.read<SubmitAnalyticsFormBloc>().add(
                  ChangeTdeeValueFromProfile(
                      tdee: context.read<SubmitFormBloc>().state.tdee,
                      percentageCarbs: 45,
                      percentageProtein: 30,
                      percentageFat: 25));
            },
          ),
        ],
      );

  Widget _pieChart(BuildContext context, SubmitAnalyticsFormState state) =>
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
                  BlocBuilder<SubmitAnalyticsFormBloc,
                      SubmitAnalyticsFormState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                            state.carbs != null ? '${state.carbs} g' : '-',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.pinkPieChart),
                          ),
                          Text(
                              state.kcalCarbs != null
                                  ? '${state.kcalCarbs} kcal'
                                  : "",
                              style: const TextStyle(
                                  color: CustomColors.pinkPieChart))
                        ],
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
                  BlocBuilder<SubmitAnalyticsFormBloc,
                      SubmitAnalyticsFormState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                              state.protein != null
                                  ? '${state.protein} g'
                                  : '-',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.bluePieChart)),
                          Text(
                              state.kcalProtein != null
                                  ? '${state.kcalProtein} kcal'
                                  : '',
                              style: const TextStyle(
                                  color: CustomColors.bluePieChart))
                        ],
                      );
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
                  BlocBuilder<SubmitAnalyticsFormBloc,
                      SubmitAnalyticsFormState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(state.fat != null ? '${state.fat} g' : '-',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.orangePieChart)),
                          Text(
                            state.kcalCarbs != null
                                ? '${state.kcalFat} kcal'
                                : '',
                            style: const TextStyle(
                                color: CustomColors.orangePieChart),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
