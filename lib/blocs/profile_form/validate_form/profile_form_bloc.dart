import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'profile_form_event.dart';

part 'profile_form_state.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc()
      : super(
          const ProfileFormState(
              type: null,
              activity: null,
              name: null,
              weight: null,
              height: null,
              age: null),
        ) {
    on<ChangedType>((event, emit) {
      emit(ProfileFormState(
          type: event.type,
          activity: state.activity,
          name: state.name,
          weight: state.weight,
          height: state.height,
          age: state.age));
    });
    on<ChangedActivity>((event, emit) {
      emit(ProfileFormState(
          activity: event.activity,
          type: state.type,
          name: state.name,
          weight: state.weight,
          height: state.height,
          age: state.age));
    });
    on<ChangedName>((event, emit) {
      emit(ProfileFormState(
          type: state.type,
          activity: state.activity,
          name: event.name,
          weight: state.weight,
          height: state.height,
          age: state.age));
    });
    on<ChangedWeight>((event, emit) {
      emit(ProfileFormState(
          type: state.type,
          activity: state.activity,
          name: state.name,
          weight: event.weight,
          height: state.height,
          age: state.age));
    });
    on<ChangedHeight>((event, emit) {
      emit(ProfileFormState(
          type: state.type,
          activity: state.activity,
          name: state.name,
          weight: state.weight,
          height: event.height,
          age: state.age));
    });
    on<ChangedAge>((event, emit) {
      emit(ProfileFormState(
          type: state.type,
          activity: state.activity,
          name: state.name,
          weight: state.weight,
          height: state.height,
          age: event.age));
    });
    on<InitialValues>((event, emit) {
      emit(ProfileFormState(
          type: event.type,
          activity: event.activity,
          name: event.name,
          weight: event.weight,
          height: event.height,
          age: event.age));
    });
  }
}
