import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect/core/failure.dart';
import 'package:pet_perfect/home/data/pet.dart';
import 'package:pet_perfect/home/repositories/pet_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PetRepository petRepository;
  HomeBloc({required this.petRepository}) : super(PetLoading()) {
    on<FetchPetEvent>(_onFetchPetEvent);
  }

  void _onFetchPetEvent(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      final pet = await petRepository.getPet();
      emit(PetLoaded(pet: pet));
    } on Failure catch (error) {
      emit(PetException(failure: error));
    }
  }
}
