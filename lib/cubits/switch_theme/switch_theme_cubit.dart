import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'switch_theme_state.dart';

class SwitchThemeCubit extends Cubit<SwitchThemeState> {
  SwitchThemeCubit() : super(const SwitchThemeState(darkMode: true),);

  void switchTheme() => emit(SwitchThemeState(darkMode: !state.darkMode));
}
