part of 'profile_form_bloc.dart';

class ProfileFormState extends Equatable {
  final String? type;
  final String? activity;
  final String? name;
  final double? weight;
  final int? height;
  final int? age;

  bool get validHeight => height != null && height != 0;

  bool get validWeight => weight != null && weight != 0;

  bool get validType => type != null && type != '';

  bool get validAge => age != null && age != 0;

  bool get validActivity => activity != null && activity != '';

  bool get validProfileForm =>
      validHeight && validWeight && validType && validAge && validActivity;

  const ProfileFormState(
      {required this.type,
      required this.activity,
      required this.name,
      required this.weight,
      required this.height,
      required this.age});

  @override
  List<Object?> get props => [type, activity, name, weight, height, age];
}
