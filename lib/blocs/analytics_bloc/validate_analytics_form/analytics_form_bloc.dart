import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/submit_analytics_form/submit_analytics_form_bloc.dart';

part 'analytics_form_event.dart';

part 'analytics_form_state.dart';

class AnalyticsFormBloc extends Bloc<AnalyticsFormEvent, AnalyticsFormState> {
  final SubmitAnalyticsFormBloc submitAnalyticsFormBloc;
  int? carbs;
  int? protein;
  int? fat;
  int? kcalCarbs;
  int? kcalProtein;
  int? kcalFat;
  Map<String, double>? dataChart;

  AnalyticsFormBloc(this.submitAnalyticsFormBloc)
      : super(AnalyticsFormState(
            tdee: submitAnalyticsFormBloc.state.tdee,
            percentageCarbs: submitAnalyticsFormBloc.dataChart != null
                ? submitAnalyticsFormBloc.dataChart!.values.first
                : null,
            percentageProtein: submitAnalyticsFormBloc.dataChart != null
                ? submitAnalyticsFormBloc.dataChart!.values.elementAt(1)
                : null,
            percentageFat: submitAnalyticsFormBloc.dataChart != null
                ? submitAnalyticsFormBloc.dataChart!.values.last
                : null,
            carbs: submitAnalyticsFormBloc.state.carbs,
            protein: submitAnalyticsFormBloc.state.protein,
            fat: submitAnalyticsFormBloc.state.fat,
            kcalCarbs: submitAnalyticsFormBloc.state.kcalCarbs,
            kcalProtein: submitAnalyticsFormBloc.state.kcalProtein,
            kcalFat: submitAnalyticsFormBloc.state.fat,
            dataChart: submitAnalyticsFormBloc.state.dataChart)) {
    on<ChangedTdee>((event, emit) {
      emit(AnalyticsFormState(
          tdee: event.tdee,
          percentageCarbs: state.percentageCarbs,
          percentageProtein: state.percentageProtein,
          percentageFat: state.percentageFat,
          carbs: state.carbs,
          protein: state.protein,
          fat: state.fat,
          kcalCarbs: state.kcalCarbs,
          kcalProtein: state.kcalProtein,
          kcalFat: state.kcalFat,
          dataChart: state.dataChart));
    });
    on<ChangedPercentageCarbs>((event, emit) {
      emit(AnalyticsFormState(
          tdee: state.tdee,
          percentageCarbs: event.percentageCarbs,
          percentageProtein: state.percentageProtein,
          percentageFat: state.percentageFat,
          carbs: state.carbs,
          protein: state.protein,
          fat: state.fat,
          kcalCarbs: state.kcalCarbs,
          kcalProtein: state.kcalProtein,
          kcalFat: state.kcalFat,
          dataChart: state.dataChart));
    });
    on<ChangedPercentageProtein>((event, emit) {
      emit(AnalyticsFormState(
          tdee: state.tdee,
          percentageCarbs: state.percentageCarbs,
          percentageProtein: event.percentageProtein,
          percentageFat: state.percentageFat,
          carbs: state.carbs,
          protein: state.protein,
          fat: state.fat,
          kcalCarbs: state.kcalCarbs,
          kcalProtein: state.kcalProtein,
          kcalFat: state.kcalFat,
          dataChart: state.dataChart));
    });
    on<ChangedPercentageFat>((event, emit) {
      emit(AnalyticsFormState(
          tdee: state.tdee,
          percentageCarbs: state.percentageCarbs,
          percentageProtein: state.percentageProtein,
          percentageFat: event.percentageFat,
          carbs: state.carbs,
          protein: state.protein,
          fat: state.fat,
          kcalCarbs: state.kcalCarbs,
          kcalProtein: state.kcalProtein,
          kcalFat: state.kcalFat,
          dataChart: state.dataChart));
    });
    on<SetPieChartValues>((event, emit) {
      calculatePercentagesMacrosPreview(
        tdee: event.tdee,
        percentageCarbs: event.percentageCarbs,
        percentageProtein: event.percentageProtein,
        percentageFat: event.percentageFat,
      );

      emit(
        AnalyticsFormState(
          tdee: state.tdee,
          percentageCarbs: state.percentageCarbs,
          percentageProtein: state.percentageProtein,
          percentageFat: state.percentageFat,
          carbs: carbs,
          protein: protein,
          fat: fat,
          kcalCarbs: kcalCarbs,
          kcalProtein: kcalProtein,
          kcalFat: kcalFat,
          dataChart: dataChart,
        ),
      );
    });
  }

  void calculatePercentagesMacrosPreview(
      {required tdee,
      required percentageCarbs,
      required percentageProtein,
      required percentageFat}) {
    carbs = ((percentageCarbs / 100) * tdee / 4).toInt();

    protein = ((percentageProtein / 100) * tdee / 4).toInt();

    fat = ((percentageFat / 100) * tdee / 9).toInt();

    kcalCarbs = (carbs! * 4);
    kcalProtein = (protein! * 4);
    kcalFat = (fat! * 9);

    dataChart = {
      "Carboidrati": percentageCarbs,
      "Proteine": percentageProtein,
      "Grassi": percentageFat,
    };
  }
}
