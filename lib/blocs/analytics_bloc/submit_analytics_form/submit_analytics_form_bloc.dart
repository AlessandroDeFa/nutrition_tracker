import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'submit_analytics_form_event.dart';

part 'submit_analytics_form_state.dart';

class SubmitAnalyticsFormBloc
    extends HydratedBloc<SubmitAnalyticsFormEvent, SubmitAnalyticsFormState> {
  int? carbs;
  int? protein;
  int? fat;
  int? kcalCarbs;
  int? kcalProtein;
  int? kcalFat;
  Map<String, double>? dataChart;

  SubmitAnalyticsFormBloc()
      : super(const SubmitAnalyticsFormState(
            tdee: null,
            carbs: null,
            protein: null,
            fat: null,
            dataChart: null,
            kcalCarbs: null,
            kcalProtein: null,
            kcalFat: null)) {
    on<ChangeTdeeValueFromProfile>((event, emit) {
      calculatePercentagesMacros(
          tdee: event.tdee,
          percentageCarbs: event.percentageCarbs,
          percentagePro: event.percentageProtein,
          percentageFat: event.percentageFat);
      emit(SubmitAnalyticsFormState(
          tdee: event.tdee,
          carbs: carbs,
          protein: protein,
          fat: fat,
          dataChart: dataChart,
          kcalCarbs: kcalCarbs,
          kcalProtein: kcalProtein,
          kcalFat: kcalFat));
    });
    on<PerformSubmitAnalytics>((event, emit) {
      calculatePercentagesMacros(
          tdee: event.tdee,
          percentageCarbs: event.percentageCarbs,
          percentagePro: event.percentageProtein,
          percentageFat: event.percentageFat);
      emit(
        SubmitAnalyticsFormState(
          tdee: event.tdee,
          carbs: carbs,
          protein: protein,
          fat: fat,
          dataChart: dataChart,
          kcalCarbs: kcalCarbs,
          kcalProtein: kcalProtein,
          kcalFat: kcalFat,
        ),
      );
    });
  }

  @override
  SubmitAnalyticsFormState? fromJson(Map<String, dynamic> json) {
    if (json['dataChart'] != null) {
      List<Map<String, dynamic>> dataChartEntries =
          List<Map<String, dynamic>>.from(jsonDecode(json['dataChart']));
      dataChart = Map<String, double>.fromEntries(dataChartEntries
          .map((entry) => MapEntry(entry['key'], entry['value'])));
    }

    return SubmitAnalyticsFormState(
      tdee: json['tdee'],
      carbs: json['carbs'],
      protein: json['protein'],
      fat: json['fat'],
      dataChart: dataChart,
      kcalCarbs: json['kcalCarbs'],
      kcalProtein: json['kcalProtein'],
      kcalFat: json['kcalFat'],
    );
  }

  @override
  Map<String, dynamic>? toJson(SubmitAnalyticsFormState state) {
    List<Map<String, dynamic>>? dataChartEntries;
    String? dataChartEntriesjson;

    if (state.dataChart != null) {
      dataChartEntries = state.dataChart!.entries
          .map((entry) => {'key': entry.key, 'value': entry.value})
          .toList();
      dataChartEntriesjson = jsonEncode(dataChartEntries);
    }

    return {
      'tdee': state.tdee,
      'carbs': state.carbs,
      'protein': state.protein,
      'fat': state.fat,
      'dataChart': dataChartEntriesjson,
      'kcalCarbs': state.kcalCarbs,
      'kcalProtein': state.kcalProtein,
      'kcalFat': state.kcalFat
    };
  }

  void calculatePercentagesMacros(
      {required tdee,
      required percentageCarbs,
      required percentagePro,
      required percentageFat}) {
    carbs = ((percentageCarbs / 100) * tdee / 4).toInt();

    protein = ((percentagePro / 100) * tdee / 4).toInt();

    fat = ((percentageFat / 100) * tdee / 9).toInt();

    kcalCarbs = (carbs! * 4);
    kcalProtein = (protein! * 4);
    kcalFat = (fat! * 9);

    dataChart = {
      "Carboidrati": percentageCarbs,
      "Proteine": percentagePro,
      "Grassi": percentageFat,
    };
  }
}
