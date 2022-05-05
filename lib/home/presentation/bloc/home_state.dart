part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class PetLoading extends HomeState {}

class PetLoaded extends HomeState {
  final Pet pet;
  const PetLoaded({required this.pet});
}

class PetVideoLoaded extends HomeState {
  final Pet pet;
  final VideoPlayerController controller;

  const PetVideoLoaded({
    required this.pet,
    required this.controller,
  });
}

class PetException extends HomeState {
  final Failure failure;
  const PetException({required this.failure});
}
