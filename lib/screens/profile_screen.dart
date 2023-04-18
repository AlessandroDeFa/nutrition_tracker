import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        border: Border(
            bottom: BorderSide(
          width: 1,
          color: CustomColors.grayColor,
        )),
        backgroundColor: Colors.transparent,
        middle: Text("Profilo"),
        trailing: Icon(
          CupertinoIcons.settings,
          size: 24,
          color: CustomColors.primaryColor,
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _listTileName(context),
            _listTileGeneralInfo(context),
            _listTileResults(context),
          ],
        ),
      ),
    );
  }

  Widget _listTileName(BuildContext context) => SliverToBoxAdapter(
        child: CupertinoListSection.insetGrouped(
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
              onTap: () {},
            ),
          ],
        ),
      );

  Widget _listTileGeneralInfo(BuildContext context) => SliverToBoxAdapter(
        child: CupertinoListSection.insetGrouped(
          backgroundColor: Colors.transparent,
          header: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text('Informazioni generali'),
          ),
          children: [
            CupertinoListTile(
              title: Text('Altezza (centimetro)'),
              additionalInfo: Text('175'),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: CustomColors.grayColor,
              ),
              onTap: () {},
            ),
            CupertinoListTile(
              title: Text('Peso corporeo (kg)'),
              additionalInfo: Text('72'),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: CustomColors.grayColor,
              ),
              onTap: () {},
            ),
            CupertinoListTile(
              title: Text('Genere'),
              additionalInfo: Text('Maschio'),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: CustomColors.grayColor,
              ),
              onTap: () {},
            ),
            CupertinoListTile(
              title: Text('Età'),
              additionalInfo: Text('21'),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: CustomColors.grayColor,
              ),
              onTap: () {},
            ),
          ],
        ),
      );

  Widget _listTileResults(BuildContext context) => SliverToBoxAdapter(
        child: CupertinoListSection.insetGrouped(
          backgroundColor: Colors.transparent,
          header: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text('Risultati'),
          ),
          children: [
            CupertinoListTile(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              leading: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: CupertinoColors.systemRed,
                ),
                child: Icon(
                  CupertinoIcons.flame_fill,
                  color: CupertinoColors.white,
                ),
              ),
              title: Text('Metabolismo basale'),
              subtitle: Text('1735 kcal', style: TextStyle(fontSize: 16)),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: CustomColors.grayColor,
              ),
            ),
            CupertinoListTile(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
              subtitle: const Text(
                '23.57',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_forward,
                color: CustomColors.grayColor,
              ),
            ),
            CupertinoListTile(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              leading: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: CupertinoColors.activeBlue,
                ),
                child: Icon(
                  CupertinoIcons.drop_fill,
                  color: CupertinoColors.white,
                ),
              ),
              title: Text('Fabbisogno idrico (ml)'),
              subtitle: Text('2500', style: TextStyle(fontSize: 16)),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: CustomColors.grayColor,
              ),
            ),
          ],
        ),
      );
}
