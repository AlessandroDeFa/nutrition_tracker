import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'switch_theme_state.dart';

class SwitchThemeCubit extends HydratedCubit<SwitchThemeState> {
  SwitchThemeCubit() : super(const SwitchThemeState(darkMode: false),);

  void switchTheme() => emit(SwitchThemeState(darkMode: !state.darkMode));

  @override
  SwitchThemeState? fromJson(Map<String, dynamic> json) {
    return SwitchThemeState(darkMode: json['darkMode'] ?? true);
  }

  @override
  Map<String, dynamic>? toJson(SwitchThemeState state) {
    return {
      'darkMode': state.darkMode
    };
  }
}
