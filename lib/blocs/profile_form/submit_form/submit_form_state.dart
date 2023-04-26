part of 'submit_form_bloc.dart';

class SubmitFormState extends Equatable {
  final String? type;
  final String? activity;
  final String? name;
  final double? weight;
  final int? height;
  final int? age;
  final int? bmr;
  final int? tdee;
  final int? waterNeeds;
  final String? imc;

  const SubmitFormState(
      {required this.type,
      required this.activity,
      required this.name,
      required this.weight,
      required this.height,
      required this.age, this.bmr, this.tdee, this.waterNeeds, this.imc,});

  @override
  List<Object?> get props => [type, activity, name, weight, height, age, bmr, tdee, waterNeeds, imc];
}
