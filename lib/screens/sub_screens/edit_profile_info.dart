import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/validate_form/profile_form_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/submit_form/submit_form_bloc.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';

class EditProfileInfo extends StatefulWidget {
  const EditProfileInfo({Key? key}) : super(key: key);

  @override
  State<EditProfileInfo> createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {

  @override
  void initState() {
    context.read<ProfileFormBloc>().add(
      InitialValues(
          type: context.read<SubmitFormBloc>().state.type,
          activity: context.read<SubmitFormBloc>().state.activity,
          name: context.read<SubmitFormBloc>().state.name,
          weight: context.read<SubmitFormBloc>().state.weight,
          height: context.read<SubmitFormBloc>().state.height,
          age: context.read<SubmitFormBloc>().state.age),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(
              bottom: BorderSide(
            width: .5,
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
          trailing: BlocBuilder<ProfileFormBloc, ProfileFormState>(
            builder: (context, state) {
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: !state.validProfileForm
                    ? null
                    : () {
                        context.read<SubmitFormBloc>().add(PerformSubmit(
                            type: state.type,
                            activity: state.activity,
                            name: state.name,
                            weight: state.weight,
                            height: state.height,
                            age: state.age));

                        Navigator.pop(context);

                      },
                child: const Text("Fine"),
              );
            },
          ),
        ),
        child: ListView(
          children: [
            _nameTextField(context),
            _generalInfoFields(context),
          ],
        ));
  }
}

Widget _nameTextField(BuildContext context) {
  final nameController = TextEditingController(
      text: context.read<SubmitFormBloc>().state.name ?? '');
  return CupertinoListSection.insetGrouped(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    backgroundColor: Colors.transparent,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: CupertinoTextField.borderless(
          controller: nameController,
          padding:
              const EdgeInsets.only(left: 65, top: 10, bottom: 10, right: 6),
          prefix: const Text("Nome"),
          maxLength: 20,
          onChanged: (value) {
            context.read<ProfileFormBloc>().add(ChangedName(name: value));
          },
        ),
      ),
    ],
  );
}

Widget _generalInfoFields(BuildContext context) {
  final heightController = TextEditingController(
      text: context.read<SubmitFormBloc>().state.height == null
          ? ''
          : context.read<SubmitFormBloc>().state.height.toString());
  final weightController = TextEditingController(
      text: context.read<SubmitFormBloc>().state.weight == null
          ? ''
          : context.read<SubmitFormBloc>().state.weight.toString());
  final ageController = TextEditingController(
      text: context.read<SubmitFormBloc>().state.age == null
          ? ''
          : context.read<SubmitFormBloc>().state.age.toString());

  return CupertinoListSection.insetGrouped(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    backgroundColor: Colors.transparent,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: CupertinoTextField.borderless(
          controller: heightController,
          padding:
              const EdgeInsets.only(left: 65, top: 10, bottom: 10, right: 6),
          prefix: const Text("Altezza"),
          placeholder: 'Obbligatorio',
          keyboardType: TextInputType.number,
          maxLength: 3,
          onChanged: (value) {
            context
                .read<ProfileFormBloc>()
                .add(ChangedHeight(height: int.tryParse(value)));
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: CupertinoTextField.borderless(
          controller: weightController,
          padding:
              const EdgeInsets.only(left: 50, top: 10, bottom: 10, right: 6),
          prefix: const Text("Peso (kg)"),
          placeholder: 'Obbligatorio',
          keyboardType: TextInputType.number,
          maxLength: 4,
          onChanged: (value) {
            context
                .read<ProfileFormBloc>()
                .add(ChangedWeight(weight: double.tryParse(value)));
          },
        ),
      ),
      CupertinoListTile(
        onTap: () {
          showCupertinoModalPopup(
              context: context,
              builder: (BuildContext builder) => _cupertinoPopUpType(context));
        },
        title: const Text('Genere'),
        additionalInfo: BlocBuilder<ProfileFormBloc, ProfileFormState>(
          builder: (context, state) {
            return Text(state.type ?? 'Obbligatorio');
          },
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        trailing: const Icon(
          CupertinoIcons.chevron_forward,
          color: CustomColors.grayColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: CupertinoTextField.borderless(
          controller: ageController,
          padding:
              const EdgeInsets.only(left: 95, top: 10, bottom: 10, right: 6),
          prefix: const Text("Età"),
          placeholder: 'Obbligatorio',
          keyboardType: TextInputType.number,
          maxLength: 3,
          onChanged: (value) {
            context
                .read<ProfileFormBloc>()
                .add(ChangedAge(age: int.tryParse(value)));
          },
        ),
      ),
      CupertinoListTile(
        onTap: () {
          showCupertinoModalPopup(
              context: context,
              builder: (BuildContext builder) =>
                  _cupertinoPopUpActivity(context));
        },
        title: const Text('Attività'),
        additionalInfo: BlocBuilder<ProfileFormBloc, ProfileFormState>(
          builder: (context, state) {
            return Text(state.activity ?? 'Obbligatorio');
          },
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        trailing: const Icon(
          CupertinoIcons.chevron_forward,
          color: CustomColors.grayColor,
        ),
      ),
    ],
  );
}

Widget _cupertinoPopUpType(BuildContext context) => CupertinoPopupSurface(
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoListTile(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onTap: () {
                context
                    .read<ProfileFormBloc>()
                    .add(const ChangedType(type: 'Maschio'));
                Navigator.pop(context);
              },
              title: const Text("Maschio"),
            ),
            CupertinoListTile(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onTap: () {
                context
                    .read<ProfileFormBloc>()
                    .add(const ChangedType(type: 'Femmina'));
                Navigator.pop(context);
              },
              title: const Text("Femmina"),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onTap: () {
                context
                    .read<ProfileFormBloc>()
                    .add(ChangedActivity(activity: "Basso"));
                Navigator.pop(context);
              },
              title: const Text("Basso"),
              subtitle: const Text(
                "Poco o nessun esercizio",
                style: TextStyle(fontSize: 13),
              ),
            ),
            CupertinoListTile(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onTap: () {
                context
                    .read<ProfileFormBloc>()
                    .add(ChangedActivity(activity: "Moderato"));
                Navigator.pop(context);
              },
              title: const Text("Moderato"),
              subtitle: const Text(
                  "Esercizio leggero, sport 1-3 volte a settimana",
                  style: TextStyle(fontSize: 13)),
            ),
            CupertinoListTile(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onTap: () {
                context
                    .read<ProfileFormBloc>()
                    .add(ChangedActivity(activity: "Alto"));
                Navigator.pop(context);
              },
              title: const Text("Alto"),
              subtitle: const Text(
                  "Esercizio moderato, sport 3-5 volte a settimana",
                  style: TextStyle(fontSize: 13)),
            ),
            CupertinoListTile(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onTap: () {
                context
                    .read<ProfileFormBloc>()
                    .add(ChangedActivity(activity: "Molto alto"));
                Navigator.pop(context);
              },
              title: const Text("Molto alto"),
              subtitle: const Text(
                  "Esercizio intenso, sport 6-7 giorni a settimana",
                  style: TextStyle(fontSize: 13)),
            ),
            CupertinoListTile(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onTap: () {
                context
                    .read<ProfileFormBloc>()
                    .add(ChangedActivity(activity: "Iperattivo"));
                Navigator.pop(context);
              },
              title: const Text("Iperattivo"),
              subtitle: const Text(
                  "Esercizio molto intenso, lavoro fisico, 2 ore o più sport",
                  style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ),
    );

Widget _suffixIcon(BuildContext context) => const Icon(
      CupertinoIcons.xmark_circle_fill,
      size: 21,
      color: CupertinoColors.inactiveGray,
    );
