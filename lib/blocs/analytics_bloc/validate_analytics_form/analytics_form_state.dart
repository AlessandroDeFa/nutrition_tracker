part of 'analytics_form_bloc.dart';

 class AnalyticsFormState extends Equatable {

   final int? tdee;
   final int? carbs;
   final int? protein;
   final int? fat;
   final Map<String, double>? dataChart;

  const AnalyticsFormState({required this.tdee, required this.carbs, required this.protein, required this.fat, required this.dataChart});

  @override

  List<Object?> get props => [tdee, carbs, protein, fat];
}
