import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'analytics_form_event.dart';

part 'analytics_form_state.dart';

class AnalyticsFormBloc extends Bloc<AnalyticsFormEvent, AnalyticsFormState> {
  int? carbs;
  int? protein;
  int? fat;
  Map<String, double>? dataChart;

  AnalyticsFormBloc()
      : super(const AnalyticsFormState(tdee: null, carbs: null, protein: null, fat: null, dataChart: null)) {
    on<ChangeTdeeValueFromProfile>((event, emit) {
      calculatePercentagesMacros(
          tdee: event.tdee, percentageCarbs: event.percentageCarbs, percentagePro: event.percentagePro, percentageFat: event.percentageFat);
      emit(AnalyticsFormState(tdee: event.tdee, carbs: carbs, protein: protein, fat: fat, dataChart: dataChart));
    });
  }

  void calculatePercentagesMacros({required tdee, required percentageCarbs, required percentagePro, required percentageFat}) {
    carbs = ((percentageCarbs / 100) * tdee / 4).toInt();

    protein = ((percentagePro / 100) * tdee / 4).toInt();

    fat = ((percentageFat / 100) * tdee / 9).toInt();

    dataChart = {
      "Carboidrati": percentageCarbs,
      "Proteine": percentagePro,
      "Grassi": percentageFat,
    };

  }
}
