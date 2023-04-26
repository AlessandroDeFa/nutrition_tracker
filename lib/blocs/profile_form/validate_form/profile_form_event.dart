part of 'profile_form_bloc.dart';

abstract class ProfileFormEvent extends Equatable {
  const ProfileFormEvent();
}

// Change type event
class ChangedType extends ProfileFormEvent {
  final String type;

  const ChangedType({required this.type});

  @override
  List<Object?> get props => [type];
}

// Change Activity event
class ChangedActivity extends ProfileFormEvent {
  final String activity;

  const ChangedActivity({required this.activity});

  @override
  List<Object?> get props => [activity];
}

// Change Name event
class ChangedName extends ProfileFormEvent {
  final String name;

  const ChangedName({required this.name});

  @override
  List<Object?> get props => [name];
}

// Change Height event
class ChangedHeight extends ProfileFormEvent {
  final int? height;

  const ChangedHeight({required this.height});

  @override
  List<Object?> get props => [height];
}

// Change Weight event
class ChangedWeight extends ProfileFormEvent {
  final double? weight;

  const ChangedWeight({required this.weight});

  @override
  List<Object?> get props => [weight];
}

// Change Age event
class ChangedAge extends ProfileFormEvent {
  final int? age;

  const ChangedAge({required this.age});

  @override
  List<Object?> get props => [age];
}


class InitialValues extends ProfileFormEvent {
  final String? type;
  final String? activity;
  final String? name;
  final double? weight;
  final int? height;
  final int? age;

  const InitialValues(
      {required this.type,
      required this.activity,
      required this.name,
      required this.weight,
      required this.height,
      required this.age});

  @override
  List<Object?> get props => [type, activity, name, weight, height, age];
}
