import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';
import 'package:nutrition_tracker/widgets/CustomNavigationBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageViewController = PageController(initialPage: 0);

    return CupertinoPageScaffold(
      navigationBar: const CustomNavigationBar(navigationBar: CupertinoNavigationBar(), title: 'Diario',),
      child: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageViewController,
              itemBuilder: (BuildContext context, int index) {
                return TestPage();
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _headerPageView(context, pageViewController),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerPageView(
          BuildContext context, PageController pageViewController) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.back,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            onPressed: () {
              pageViewController.previousPage(
                duration: Duration(microseconds: 200),
                curve: Curves.linear,
              );
            },
          ),
          const Text("Oggi"),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.chevron_forward,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            onPressed: () {
              pageViewController.nextPage(
                duration: const Duration(microseconds: 200),
                curve: Curves.linear,
              );
            },
          ),
        ],
      );
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('test'),
    );
  }
}

