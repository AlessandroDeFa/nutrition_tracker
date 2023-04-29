part of 'analytics_form_bloc.dart';

abstract class AnalyticsFormEvent extends Equatable {
  const AnalyticsFormEvent();
}

class ChangedTdee extends AnalyticsFormEvent {
  final int? tdee;

  const ChangedTdee({required this.tdee});

  @override
  List<Object?> get props => [tdee];
}

class ChangedPercentageCarbs extends AnalyticsFormEvent {
  final double? percentageCarbs;

  const ChangedPercentageCarbs({required this.percentageCarbs});

  @override
  List<Object?> get props => [percentageCarbs];
}

class ChangedPercentageProtein extends AnalyticsFormEvent {
  final double? percentageProtein;

  const ChangedPercentageProtein({required this.percentageProtein});

  @override
  List<Object?> get props => [percentageProtein];
}

class ChangedPercentageFat extends AnalyticsFormEvent {
  final double? percentageFat;

  const ChangedPercentageFat({required this.percentageFat});

  @override
  List<Object?> get props => [percentageFat];
}

class SetPieChartValues extends AnalyticsFormEvent {
  final int? tdee;
  final double? percentageCarbs;
  final double? percentageProtein;
  final double? percentageFat;

  const SetPieChartValues(
      {required this.tdee,
      required this.percentageCarbs,
      required this.percentageProtein,
      required this.percentageFat});

  @override
  List<Object?> get props =>
      [tdee, percentageCarbs, percentageProtein, percentageFat];
}
