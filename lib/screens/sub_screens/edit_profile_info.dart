import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';

class EditProfileInfo extends StatelessWidget {
  const EditProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: CupertinoTheme.of(context).primaryContrastingColor,
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
                  'Profilo',
                  style: TextStyle(color: CustomColors.primaryColor),
                )
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          middle: const Text("Modifica Profilo"),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Text("Fine"),
          ),
        ),
        child: ListView(
          children: [
            _nameTextField(context),
            _generalInfoFields(context),
          ],
        ));
  }

  Widget _nameTextField(BuildContext context) =>
      CupertinoListSection.insetGrouped(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        backgroundColor: Colors.transparent,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: CupertinoTextField.borderless(
              padding: EdgeInsets.only(left: 65, top: 10, bottom: 10, right: 6),
              prefix: Text("Nome"),
              maxLength: 20,
            ),
          ),
        ],
      );

  Widget _generalInfoFields(BuildContext context) =>
      CupertinoListSection.insetGrouped(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        backgroundColor: Colors.transparent,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: CupertinoTextField.borderless(
              padding: EdgeInsets.only(left: 65, top: 10, bottom: 10, right: 6),
              prefix: Text("Altezza"),
              placeholder: 'Obbligatorio',
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: CupertinoTextField.borderless(
              padding: EdgeInsets.only(left: 50, top: 10, bottom: 10, right: 6),
              prefix: Text("Peso (kg)"),
              placeholder: 'Obbligatorio',
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
          ),
          CupertinoListTile(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext builder) =>
                      _cupertinoPopUpType(context));
            },
            title: Text('Genere'),
            additionalInfo: Text("Maschio"),
            padding: EdgeInsets.symmetric(horizontal: 10),
            trailing: Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: CupertinoTextField.borderless(
              padding: EdgeInsets.only(left: 95, top: 10, bottom: 10, right: 6),
              prefix: Text("Età"),
              placeholder: 'Obbligatorio',
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
          ),
          CupertinoListTile(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext builder) =>
                      _cupertinoPopUpActivity(context));
            },
            title: Text('Attività'),
            additionalInfo: Text("Moderato"),
            padding: EdgeInsets.symmetric(horizontal: 10),
            trailing: Icon(
              CupertinoIcons.chevron_forward,
              color: CustomColors.grayColor,
            ),
          ),
        ],
      );

  Widget _cupertinoPopUpType(BuildContext context) => CupertinoPopupSurface(
        child: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoListTile(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                onTap: () {},
                title: Text("Maschio"),
              ),
              CupertinoListTile(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                onTap: () {},
                title: Text("Femmina"),
              ),
            ],
          ),
        ),
      );

  Widget _cupertinoPopUpActivity(BuildContext context) => CupertinoPopupSurface(
        child: SizedBox(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoListTile(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                onTap: () {},
                title: Text("Basso"),
                subtitle: Text("Poco o nessun esercizio", style: TextStyle(fontSize: 13),),
              ),
              CupertinoListTile(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                onTap: () {},
                title: Text("Moderato"),
                subtitle:
                    Text("Esercizio leggero, sport 1-3 volte a settimana", style: TextStyle(fontSize: 13)),
              ),
              CupertinoListTile(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                onTap: () {},
                title: Text("Alto"),
                subtitle:
                    Text("Esercizio moderato, sport 3-5 volte a settimana", style: TextStyle(fontSize: 13)),
              ),
              CupertinoListTile(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                onTap: () {},
                title: Text("Molto alto"),
                subtitle:
                    Text("Esercizio intenso, sport 6-7 giorni a settimana", style: TextStyle(fontSize: 13)),
              ),
              CupertinoListTile(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                onTap: () {},
                title: Text("Iperattivo"),
                subtitle: Text(
                    "Esercizio molto intenso, lavoro fisico, 2 ore o più sport", style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
      );
}
