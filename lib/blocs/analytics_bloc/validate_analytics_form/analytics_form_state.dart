part of 'analytics_form_bloc.dart';

class AnalyticsFormState extends Equatable {
  final int? tdee;
  final double? percentageCarbs;
  final double? percentageProtein;
  final double? percentageFat;
  final int? carbs;
  final int? protein;
  final int? fat;
  final int? kcalCarbs;
  final int? kcalProtein;
  final int? kcalFat;
  final Map<String, double>? dataChart;

  bool get validTdee => tdee != null;

  bool get validCarbs => percentageCarbs != null;

  bool get validProtein => percentageProtein != null;

  bool get validFat => percentageFat != null;

  bool get validAnalyticsForm =>
      validTdee &&
      validCarbs &&
      validProtein &&
      validFat &&
      percentageProtein! + percentageCarbs! + percentageFat! == 100;

  const AnalyticsFormState(
      {required this.tdee,
      required this.percentageCarbs,
      required this.percentageProtein,
      required this.percentageFat,required this.carbs,required this.protein,required this.fat,required this.kcalCarbs,
        required  this.kcalProtein,required this.kcalFat,required this.dataChart,});

  @override
  List<Object?> get props =>
      [tdee, percentageCarbs, percentageProtein, percentageFat, carbs, protein, fat, kcalFat, kcalProtein, kcalCarbs, dataChart];
}
