import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/submit_analytics_form/submit_analytics_form_bloc.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/validate_analytics_form/analytics_form_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/submit_form/submit_form_bloc.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';
import 'package:pie_chart/pie_chart.dart';

Map<String, double> dataMap = {
  "Carboidrati": 50,
  "Proteine": 25,
  "Grassi": 25,
};

class AnalyticsBottomSheet extends StatelessWidget {
  const AnalyticsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kcalController = TextEditingController(
        text: context.read<AnalyticsFormBloc>().state.tdee != null
            ? context.read<AnalyticsFormBloc>().state.tdee.toString()
            : '');
    final carbsController = TextEditingController(
        text: context.read<AnalyticsFormBloc>().state.percentageCarbs != null
            ? context.read<AnalyticsFormBloc>().state.percentageCarbs.toString()
            : '');
    final proteinController = TextEditingController(
        text: context.read<AnalyticsFormBloc>().state.percentageProtein != null
            ? context
                .read<AnalyticsFormBloc>()
                .state
                .percentageProtein
                .toString()
            : '');
    final fatController = TextEditingController(
        text: context.read<AnalyticsFormBloc>().state.percentageFat != null
            ? context.read<AnalyticsFormBloc>().state.percentageFat.toString()
            : '');

    return Container(
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
                        padding: const EdgeInsets.all(13),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Column(
                          children: [
                            BlocBuilder<AnalyticsFormBloc, AnalyticsFormState>(
                              builder: (context, state) {
                                return Text(
                                  state.tdee != null
                                      ? '${state.tdee} kcal'
                                      : '0 kcal',
                                  style: const TextStyle(fontSize: 25),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                'Calorie di mantenimento: ${context.read<SubmitFormBloc>().state.tdee ?? ''}',
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  backgroundColor: Colors.transparent,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: CupertinoTextField.borderless(
                        keyboardType: TextInputType.number,
                        controller: kcalController,
                        padding: const EdgeInsets.only(
                            left: 65, top: 10, bottom: 10, right: 6),
                        prefix: const Text("Requisito calorico"),
                        maxLength: 5,
                        onChanged: (value) {
                          context
                              .read<AnalyticsFormBloc>()
                              .add(ChangedTdee(tdee: int.tryParse(value)));
                        },
                      ),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                        controller: carbsController,
                        prefix: const Text("Carboidrati (%)"),
                        maxLength: 5,
                        onChanged: (value) {
                          context.read<AnalyticsFormBloc>().add(
                              ChangedPercentageCarbs(
                                  percentageCarbs: double.tryParse(value)));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: CupertinoTextField.borderless(
                        placeholder: '40',
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        controller: proteinController,
                        prefix: const Text("Proteine (%)"),
                        maxLength: 5,
                        onChanged: (value) {
                          context.read<AnalyticsFormBloc>().add(
                              ChangedPercentageProtein(
                                  percentageProtein: double.tryParse(value)));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: CupertinoTextField.borderless(
                        placeholder: '10',
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        controller: fatController,
                        prefix: const Text("Grassi (%)"),
                        maxLength: 5,
                        onChanged: (value) {
                          context.read<AnalyticsFormBloc>().add(
                              ChangedPercentageFat(
                                  percentageFat: double.tryParse(value)));
                        },
                      ),
                    ),
                  ],
                ),
                BlocListener<AnalyticsFormBloc, AnalyticsFormState>(
                  listener: (context, state) {
                    state.validAnalyticsForm
                        ? context.read<AnalyticsFormBloc>().add(
                            SetPieChartValues(
                                tdee: state.tdee,
                                percentageCarbs: state.percentageCarbs,
                                percentageProtein: state.percentageProtein,
                                percentageFat: state.percentageFat))
                        : null;
                  },
                  child: BlocBuilder<AnalyticsFormBloc, AnalyticsFormState>(
                    builder: (context, state) {
                      return state.validAnalyticsForm
                          ? _pieChartPreview(context, state)
                          : Container();
                    },
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<AnalyticsFormBloc, AnalyticsFormState>(
            builder: (context, state) {
              return CupertinoButton(
                  onPressed: !state.validAnalyticsForm
                      ? null
                      : () {
                          context.read<SubmitAnalyticsFormBloc>().add(
                                PerformSubmitAnalytics(
                                    tdee: state.tdee,
                                    percentageCarbs:
                                        state.percentageCarbs!.toDouble(),
                                    percentageProtein:
                                        state.percentageProtein!.toDouble(),
                                    percentageFat:
                                        state.percentageFat!.toDouble()),
                              );
                          Navigator.pop(context);
                        },
                  child: CupertinoListSection.insetGrouped(
                    margin: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    children: [
                      CupertinoListTile(
                        title: Text(
                          'Salva modifiche',
                          style: TextStyle(
                              color: state.validAnalyticsForm
                                  ? CupertinoTheme.of(context).primaryColor
                                  : CupertinoColors.inactiveGray),
                        ),
                      ),
                    ],
                  ));
            },
          ),
        ],
      ),
    );
  }

  Widget _pieChartPreview(BuildContext context, AnalyticsFormState state) => Column(
        children: [
          _legendsPieChartPreview(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PieChart(
              chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: false,
                  chartValueStyle: TextStyle(color: CustomColors.textColor)),
              chartLegendSpacing: 20,
              dataMap: state.dataChart ?? dataMap,
              chartRadius: MediaQuery.of(context).size.width * 0.3,
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
      );

  Widget _legendsPieChartPreview(BuildContext context) => Padding(
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
                  BlocBuilder<AnalyticsFormBloc,
                      AnalyticsFormState>(
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
                  BlocBuilder<AnalyticsFormBloc,
                      AnalyticsFormState>(
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
                  BlocBuilder<AnalyticsFormBloc,
                      AnalyticsFormState>(
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
