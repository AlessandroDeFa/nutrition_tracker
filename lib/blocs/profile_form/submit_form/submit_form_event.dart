part of 'submit_form_bloc.dart';

abstract class SubmitFormEvent extends Equatable {
  const SubmitFormEvent();
}

class PerformSubmit extends SubmitFormEvent {
  final String? type;
  final String? activity;
  final String? name;
  final double? weight;
  final int? height;
  final int? age;

  const PerformSubmit(
      {required this.type,
      required this.activity,
      required this.name,
      required this.weight,
      required this.height,
      required this.age});

  @override
  List<Object?> get props => [type, activity, name, weight, height, age];
}
