import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'analytics_form_event.dart';
part 'analytics_form_state.dart';

class AnalyticsFormBloc extends Bloc<AnalyticsFormEvent, AnalyticsFormState> {
  AnalyticsFormBloc() : super(AnalyticsFormInitial()) {
    on<AnalyticsFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
