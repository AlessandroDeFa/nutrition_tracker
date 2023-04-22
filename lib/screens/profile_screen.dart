import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker/screens/sub_screens/edit_profile_info.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';
import 'package:nutrition_tracker/widgets/CustomNavigationBar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void editProfileScreen() {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => const EditProfileInfo()));
    }

    return CupertinoPageScaffold(
      navigationBar: const CustomNavigationBar(navigationBar: CupertinoNavigationBar(), title: 'Profilo',),
      child: ListView(
        children: [
          _listTileName(context, editProfileScreen),
          _listTileGeneralInfo(context, editProfileScreen),
          _listTileResults(context),
        ],
      ),
    );
  }

  Widget _listTileName(BuildContext context, editProfileScreen) =>
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        header: const Padding(
          padding: EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Text('Nome Account'),
        ),
        children: [
          CupertinoListTile(
            title: Text('Nome'),
            trailing: Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {
              editProfileScreen();
  }

            ,
          ),
        ],
      );

  Widget _listTileGeneralInfo(BuildContext context, editProfileScreen) =>
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        header: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text('Informazioni generali'),
        ),
        children: [
          CupertinoListTile(
            title: const Text('Altezza (centimetro)'),
            additionalInfo: Text('175'),
            trailing: Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {
              editProfileScreen();
            },
          ),
          CupertinoListTile(
            title: const Text('Peso corporeo (kg)'),
            additionalInfo: Text('72'),
            trailing: Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {
              editProfileScreen();
            },
          ),
          CupertinoListTile(
            title: const Text('Genere'),
            additionalInfo: Text('Maschio'),
            trailing: const Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {
              editProfileScreen();
            },
          ),
          CupertinoListTile(
            title: const Text('Età'),
            additionalInfo: Text('21'),
            trailing: const Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {
              editProfileScreen();
            },
          ),
          CupertinoListTile(
            title: const Text('Attività'),
            additionalInfo: Text('Moderato'),
            trailing: const Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {
              editProfileScreen();
            },
          ),
        ],
      );

  Widget _listTileResults(BuildContext context) =>
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        header: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text('Risultati'),
        ),
        children: [
          CupertinoListTile(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            leading: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: CupertinoColors.systemRed,
              ),
              child: const Icon(
                CupertinoIcons.flame_fill,
                color: CupertinoColors.white,
              ),
            ),
            title: const Text('Metabolismo basale'),
            subtitle: Text('1735 kcal', style: TextStyle(fontSize: 16)),

          ),
          CupertinoListTile(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            leading: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: CupertinoColors.activeOrange,
              ),
              child: const Icon(
                Icons.speed_rounded,
                color: Colors.white,
              ),
            ),
            title: const Text('Indice di massa corporea'),
            subtitle: Text(
              '23.57',
              style: TextStyle(fontSize: 16),
            ),

          ),
          CupertinoListTile(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            leading: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: CupertinoColors.activeBlue,
              ),
              child: const Icon(
                CupertinoIcons.drop_fill,
                color: CupertinoColors.white,
              ),
            ),
            title: const Text('Fabbisogno idrico (ml)'),
            subtitle: Text('2500', style: TextStyle(fontSize: 16)),
          ),
        ],
      );
}
