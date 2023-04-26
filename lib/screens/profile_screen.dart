import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/profile_form_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/submit_form/submit_form_bloc.dart';
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
      navigationBar: const CustomNavigationBar(
        navigationBar: CupertinoNavigationBar(), title: 'Profilo',),
      child: BlocBuilder<SubmitFormBloc, SubmitFormState>(
        builder: (context, state) {
          return ListView(
            children: [
              _listTileName(context, editProfileScreen, state),
              _listTileGeneralInfo(context, editProfileScreen, state),
              _listTileResults(context,state),
            ],
          );
        },
      ),
    );
  }

  Widget _listTileName(BuildContext context, editProfileScreen, SubmitFormState state) =>
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
            title: Text(state.name != null && state.name != '' ? state.name! : 'Nome'),
            trailing: const Icon(
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

  Widget _listTileGeneralInfo(BuildContext context, editProfileScreen, SubmitFormState state) =>
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        header: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text('Informazioni generali'),
        ),
        children: [
          CupertinoListTile(
            title: const Text('Altezza (centimetro)'),
            additionalInfo: Text(state.height != null ? state.height.toString() :  '-'),
            trailing: const Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {
              editProfileScreen();
            },
          ),
          CupertinoListTile(
            title: const Text('Peso corporeo (kg)'),
            additionalInfo: Text(state.weight != null ? state.weight.toString() : '-'),
            trailing: const Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
            onTap: () {
              editProfileScreen();
            },
          ),
          CupertinoListTile(
            title: const Text('Genere'),
            additionalInfo: Text(state.type ?? '-'),
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
            additionalInfo: Text(state.age != null ? state.age.toString() : '-'),
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
            additionalInfo: Text(state.activity ?? '-'),
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

  Widget _listTileResults(BuildContext context, SubmitFormState state) =>
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
            subtitle: Text(state.bmr != null ? '${state.bmr} kcal' : '-', style: TextStyle(fontSize: 16)),

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
            subtitle: Text(state.imc != null ? state.imc! : '-',
              style: const TextStyle(fontSize: 16),
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
            subtitle: Text(state.waterNeeds != null ? '${state.waterNeeds}' : '-', style: const TextStyle(fontSize: 16)),
          ),
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
                Icons.whatshot,
                color: CupertinoColors.white,
              ),
            ),
            title: const Text('Fabbisogno calorico (TDEE)'),
            subtitle: Text(state.waterNeeds != null ? '${state.tdee} kcal' : '-', style: const TextStyle(fontSize: 16)),
          ),
        ],
      );
}

// CRAERE LA FUNZIONE ANCHE PER IL TYPE FEMMINA

