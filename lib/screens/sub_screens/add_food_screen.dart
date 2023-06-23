import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border.all(width: 0, color: Colors.transparent),
        leading: CupertinoButton(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.zero,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.back,
                size: 24,
                color: CustomColors.primaryColor,
              ),
              Text(
                'Indietro',
                style: TextStyle(color: CustomColors.primaryColor),
              )
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: const Text('Alimenti'),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: CupertinoTheme.of(context).barBackgroundColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: const CupertinoSearchTextField(
                  placeholder: 'Search',
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
