import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'submit_form_event.dart';

part 'submit_form_state.dart';

class SubmitFormBloc extends HydratedBloc<SubmitFormEvent, SubmitFormState> {
  int? bmr;
  String? imc;
  int? waterNeeds;
  int? tdee;
  double activityFactor = 1;

  SubmitFormBloc()
      : super(const SubmitFormState(
            type: null,
            activity: null,
            name: null,
            weight: null,
            height: null,
            age: null,
            bmr: null,
            tdee: null,
            waterNeeds: null,
            imc: null)) {
    on<PerformSubmit>((event, emit) {
      calculateTdee(
          activity: event.activity,
          type: event.type,
          weight: event.weight,
          height: event.height,
          age: event.age);

      emit(SubmitFormState(
          type: event.type,
          activity: event.activity,
          name: event.name,
          weight: event.weight,
          height: event.height,
          age: event.age,
          bmr: bmr,
          tdee: tdee,
          waterNeeds: waterNeeds,
          imc: imc));
    });
  }

  @override
  SubmitFormState? fromJson(Map<String, dynamic> json) {
    return SubmitFormState(
        type: json['type'],
        activity: json['activity'],
        name: json['name'],
        weight: json['weight'],
        height: json['height'],
        age: json['age'],
        bmr: json['bmr'],
        tdee: json['tdee'],
        waterNeeds: json['waterNeeds'],
        imc: json['imc']);
  }

  @override
  Map<String, dynamic>? toJson(SubmitFormState state) {
    return {
      'name': state.name,
      'height': state.height,
      'weight': state.weight,
      'type': state.type,
      'age': state.age,
      'activity': state.activity,
      'bmr': state.bmr,
      'tdee': state.tdee,
      'waterNeeds': state.waterNeeds,
      'imc': state.imc
    };
  }

  void calculateTdee(
      {required String? activity,
      required String? type,
      required double? weight,
      required int? height,
      required int? age}) {
    switch (activity) {
      case 'Basso':
        {
          activityFactor = 1.2;
          break;
        }
      case 'Moderato':
        {
          activityFactor = 1.375;
          break;
        }
      case 'Alto':
        {
          activityFactor = 1.55;
          break;
        }
      case 'Molto alto':
        {
          activityFactor = 1.725;
          break;
        }
      case 'Iperattivo':
        {
          activityFactor = 1.9;
          break;
        }
    }

    if (type == "Maschio") {
      bmr = ((10 * weight!) + (6.25 * height!) - (5 * age!) + 5).toInt();
    } else {
      bmr = ((10 * weight!) + (6.25 * height!) - (5 * age!) - 161).toInt();
    }

    waterNeeds = (weight * 0.03 * 1000).toInt();

    tdee = (bmr! * activityFactor).toInt();

    imc = (weight / ((height / 100) * (height / 100))).toStringAsFixed(2);
  }
}
