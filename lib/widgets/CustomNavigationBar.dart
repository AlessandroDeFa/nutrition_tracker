import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker/screens/sub_screens/settings_screen.dart';

class CustomNavigationBar extends StatelessWidget implements ObstructingPreferredSizeWidget {
  
  final CupertinoNavigationBar navigationBar;
  final String title;
  
  const CustomNavigationBar({Key? key, required this.navigationBar, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: Border(
          bottom: BorderSide(
            width: .5,
            color: CupertinoTheme.of(context).primaryContrastingColor,
          )),
      // backgroundColor: Colors.transparent,
      middle: Text(title),
      trailing: CupertinoButton(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(0.0),
          child:  Icon(
            CupertinoIcons.settings,
            size: 24,
            color: CupertinoTheme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const SettingsScreen()));
          }),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(navigationBar.preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
