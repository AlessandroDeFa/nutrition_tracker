part of 'switch_theme_cubit.dart';

@immutable
class SwitchThemeState extends Equatable {
  final bool darkMode;
  const SwitchThemeState({required this.darkMode});

  @override
  // TODO: implement props
  List<Object?> get props => [darkMode];
}
