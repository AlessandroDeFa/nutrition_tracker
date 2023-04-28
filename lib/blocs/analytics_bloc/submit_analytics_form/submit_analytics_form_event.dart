part of 'submit_analytics_form_bloc.dart';

abstract class SubmitAnalyticsFormEvent extends Equatable {
  const SubmitAnalyticsFormEvent();
}

class ChangeTdeeValueFromProfile extends SubmitAnalyticsFormEvent {
  final int? tdee;
  final double? percentageCarbs;
  final double? percentagePro;
  final double? percentageFat;

  const ChangeTdeeValueFromProfile({required this.tdee, required this.percentageCarbs, required this.percentagePro, required this.percentageFat});

  @override
  List<Object?> get props => [tdee, percentageCarbs, percentagePro, percentageFat];
}

