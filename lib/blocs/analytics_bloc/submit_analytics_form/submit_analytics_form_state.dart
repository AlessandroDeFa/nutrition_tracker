part of 'submit_analytics_form_bloc.dart';

class SubmitAnalyticsFormState extends Equatable {
  final int? tdee;
  final int? carbs;
  final int? protein;
  final int? fat;
  final int? kcalCarbs;
  final int? kcalProtein;
  final int? kcalFat;
  final Map<String, double>? dataChart;

  const SubmitAnalyticsFormState({
    required this.tdee,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.dataChart,
    required this.kcalCarbs,
    required this.kcalProtein,
    required this.kcalFat
  });

  @override
  List<Object?> get props => [tdee, carbs, protein, fat, dataChart, kcalProtein, kcalFat, kcalCarbs];
}
