part of 'analytics_form_bloc.dart';

abstract class AnalyticsFormEvent extends Equatable {
  const AnalyticsFormEvent();
}

class ChangeTdeeValueFromProfile extends AnalyticsFormEvent {
  final int? tdee;
  final double? percentageCarbs;
  final double? percentagePro;
  final double? percentageFat;

  const ChangeTdeeValueFromProfile({required this.tdee, required this.percentageCarbs, required this.percentagePro, required this.percentageFat});

  @override
  List<Object?> get props => [tdee, percentageCarbs, percentagePro, percentageFat];
}

