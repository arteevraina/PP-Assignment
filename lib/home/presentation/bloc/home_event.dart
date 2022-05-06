part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchPetEvent extends HomeEvent {}

class SavePetEvent extends HomeEvent {
  final Pet pet;
  const SavePetEvent({required this.pet});
}
