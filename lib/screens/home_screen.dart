import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/submit_analytics_form/submit_analytics_form_bloc.dart';
import 'package:nutrition_tracker/screens/sub_screens/add_food_screen.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';
import 'package:nutrition_tracker/widgets/custom_navigation_bar.dart';
import 'package:pull_down_button/pull_down_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CustomNavigationBar(
        navigationBar: CupertinoNavigationBar(),
        title: 'Diario',
      ),
      child: SafeArea(
        child: ListView(
          children: [
            _headerPageView(context),
            _summaryHeader(context),
            _breakfastSection(context),
          ],
        ),
      ),
    );
  }

  Widget _headerPageView(BuildContext context) => Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.back,
                  color: CupertinoTheme.of(context).primaryColor,
                ),
                onPressed: () {},
              ),
              const Text("Oggi"),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.chevron_forward,
                  color: CupertinoTheme.of(context).primaryColor,
                ),
                onPressed: () {},
              ),
            ],

          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: _contextMenu(context),
          ),
        ],
      );

  Widget _summaryHeader(BuildContext context) =>
      CupertinoListSection.insetGrouped(
        dividerMargin: double.infinity,
        backgroundColor: Colors.transparent,
        children: [
          CupertinoListTile(
              title: Column(
            children: [
              _summaryMacros(context),
              _summaryTdee(context),
            ],
          )),
          _btnAnalyses(context),
        ],
      );

  Widget _summaryMacros(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Carboidrati',
                    style: TextStyle(color: CustomColors.pinkPieChart),
                  ),
                  BlocBuilder<SubmitAnalyticsFormBloc,
                      SubmitAnalyticsFormState>(
                    builder: (context, state) {
                      return Text('0 / ${state.carbs ?? 0} g',
                          style: const TextStyle(
                              color: CustomColors.pinkPieChart,
                              fontWeight: FontWeight.bold,
                              fontSize: 16));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text('Proteine',
                      style: TextStyle(color: CustomColors.bluePieChart)),
                  BlocBuilder<SubmitAnalyticsFormBloc,
                      SubmitAnalyticsFormState>(
                    builder: (context, state) {
                      return Text('0 / ${state.protein ?? 0} g',
                          style: const TextStyle(
                              color: CustomColors.bluePieChart,
                              fontWeight: FontWeight.bold,
                              fontSize: 16));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text('Grassi',
                      style: TextStyle(color: CustomColors.orangePieChart)),
                  BlocBuilder<SubmitAnalyticsFormBloc,
                      SubmitAnalyticsFormState>(
                    builder: (context, state) {
                      return Text('0 / ${state.fat ?? 0} g',
                          style: const TextStyle(
                              color: CustomColors.orangePieChart,
                              fontWeight: FontWeight.bold,
                              fontSize: 16));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _summaryTdee(BuildContext context) =>
      BlocBuilder<SubmitAnalyticsFormBloc, SubmitAnalyticsFormState>(
        builder: (context, state) {
          return Text(
            '0 / ${state.tdee ?? 0} kcal',
            style:
                const TextStyle(color: CustomColors.bluePieChart, fontSize: 15),
          );
        },
      );

  Widget _btnAnalyses(BuildContext context) => CupertinoListTile(
      padding: EdgeInsets.zero,
      title: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            'ANALISI',
            style: TextStyle(
                color: CupertinoTheme.of(context).primaryColor, fontSize: 16),
          )),
      onTap: () {});

  Widget _btnAddFood(BuildContext context) => CupertinoListTile(
      title: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  CupertinoIcons.add_circled_solid,
                  size: 17,
                ),
              ),
              Text(
                'Aggiungi cibo',
                style: TextStyle(
                    color: CupertinoTheme.of(context).primaryColor,
                    fontSize: 16),
              ),
            ],
          )),
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const AddFoodScreen()));
      });

  Widget _breakfastSection(BuildContext context) =>
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        header: const Padding(
          padding: EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Text('Colazione'),
        ),
        children: [
          CupertinoListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latte parzialmente scremato UHT',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '118',
                    style: TextStyle(
                        color: CustomColors.bluePieChart, fontSize: 14),
                  ),
                ],
              ),
              subtitle: Text('Land, 250g'),
              onTap: () {}),
          _btnAddFood(context),
          const CupertinoListTile(
              title: Padding(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('0',
                          style: TextStyle(
                              color: CustomColors.pinkPieChart, fontSize: 14)),
                      Text(
                        'Carboidrati',
                        style: TextStyle(
                            color: CustomColors.pinkPieChart, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('0',
                          style: TextStyle(
                              color: CustomColors.bluePieChart, fontSize: 14)),
                      Text('Proteine',
                          style: TextStyle(
                              color: CustomColors.bluePieChart, fontSize: 14)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('0',
                          style: TextStyle(
                              color: CustomColors.orangePieChart,
                              fontSize: 14)),
                      Text('Grassi',
                          style: TextStyle(
                              color: CustomColors.orangePieChart,
                              fontSize: 14)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('0',
                          style: TextStyle(
                              color: CustomColors.bluePieChart, fontSize: 14)),
                      Text('Calorie',
                          style: TextStyle(
                              color: CustomColors.bluePieChart, fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      );

  Widget _contextMenu(BuildContext context) => PullDownButton(
    itemBuilder: (context) => [
      PullDownMenuItem(
        title: 'Analisi',
        iconWidget: const Icon(CupertinoIcons.chart_bar_square, size: 20,),
        onTap: () {},
      ),
      PullDownMenuItem(
        title: 'Annulla',
        onTap: () {},
      ),
    ],
    buttonBuilder: (context, showMenu) => CupertinoButton(
      onPressed: showMenu,
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.ellipsis_circle),
    ),
  );
}
