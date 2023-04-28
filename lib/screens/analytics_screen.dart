import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/submit_analytics_form/submit_analytics_form_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/submit_form/submit_form_bloc.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';
import 'package:nutrition_tracker/widgets/CustomNavigationBar.dart';
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
                builder: (context) => _analyticsBottomSheet(context),
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
                      percentageCarbs: 45.0,
                      percentagePro: 30.0,
                      percentageFat: 25.0));
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
                          Text(state.kcalCarbs != null ? '${state.kcalCarbs} kcal' : "", style:  const TextStyle(color: CustomColors.pinkPieChart))
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
                          Text(state.kcalProtein != null ? '${state.kcalProtein} kcal' : '', style:  const TextStyle(color: CustomColors.bluePieChart))
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
                          Text(state.kcalCarbs != null ? '${state.kcalFat} kcal' : '', style:  const TextStyle(color: CustomColors.orangePieChart),)
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

  Widget _analyticsBottomSheet(BuildContext context) => Container(
        height: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: CupertinoButton(
                        alignment: Alignment.centerLeft,
                        child: const Text('Annulla'),
                        onPressed: () {
                          Navigator.pop(context);
                        })),
                const Expanded(
                    flex: 2,
                    child: Text(
                      'Requisito caloarico',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  CupertinoListSection(
                    backgroundColor: Colors.transparent,
                    children: [
                      CupertinoListTile.notched(
                        title: Container(
                          padding: EdgeInsets.all(13),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                '1900 kcal',
                                style: const TextStyle(fontSize: 25),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  'Calorie di mantenimento: ${context.read<SubmitFormBloc>().state.tdee}',
                                  style: const TextStyle(
                                      color: CupertinoColors.inactiveGray),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection.insetGrouped(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    backgroundColor: Colors.transparent,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        child: CupertinoTextField.borderless(
                          keyboardType: TextInputType.number,
                          // controller: nameController,
                          padding: const EdgeInsets.only(
                              left: 65, top: 10, bottom: 10, right: 6),
                          prefix: const Text("Requisito calorico"),
                          maxLength: 5,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection.insetGrouped(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    backgroundColor: Colors.transparent,
                    header: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Distribuzione dei Macronutrienti'),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        child: CupertinoTextField.borderless(
                          placeholder: '50',
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          // controller: nameController,

                          prefix: const Text("Carboidrati (%)"),
                          maxLength: 2,
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        child: CupertinoTextField.borderless(
                          placeholder: '40',
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          // controller: nameController,
                          prefix: const Text("Proteine (%)"),
                          maxLength: 2,
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        child: CupertinoTextField.borderless(
                          placeholder: '10',
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          // controller: nameController,

                          prefix: const Text("Grassi (%)"),
                          maxLength: 2,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            CupertinoButton(
              child: CupertinoListSection.insetGrouped(
                margin: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                children: [
                  CupertinoListTile(
                    title: Text(
                      'Salva modifiche',
                      style: TextStyle(
                          color: CupertinoTheme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              onPressed: null,
            )
          ],
        ),
      );
}
