import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tracker/cubits/switch_theme/switch_theme_cubit.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border(
            bottom: BorderSide(
              width: .5,
              color: CupertinoTheme
                  .of(context)
                  .primaryContrastingColor,
            )),
        backgroundColor: Colors.transparent,
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
        middle: const Text("Impostazioni"),
      ),
      child: ListView(
        children: [
          _themeMode(context),
        ],
      ),
    );
  }

  Widget _themeMode(BuildContext context) =>
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        header: const Padding(
          padding: EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Text('Impostazioni del tema'),
        ),
        children: [
          BlocBuilder<SwitchThemeCubit, SwitchThemeState>(
            builder: (context, state) {
              return CupertinoListTile(
                title: const Text("Modalità scura"),
                trailing: CupertinoSwitch(
                  value: state.darkMode,
                  onChanged: (bool value) {
                    context.read<SwitchThemeCubit>().switchTheme();
                  },
                ),
              );
            },
          ),
          const CupertinoListTile(
            title: Text("Formula"),
            trailing: Text("Mifflin-St Jeor"),
          )
        ],
      );
}
