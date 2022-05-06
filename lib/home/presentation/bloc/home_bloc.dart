import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

import '/core/failure.dart';
import '/home/data/pet.dart';
import '/home/repositories/pet_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PetRepository petRepository;
  HomeBloc({required this.petRepository}) : super(PetLoading()) {
    on<FetchPetEvent>(_onFetchPetEvent);
    on<SavePetEvent>(_onSavePetEvent);
  }

  void _onFetchPetEvent(FetchPetEvent event, Emitter<HomeState> emit) async {
    try {
      final pet = await petRepository.getPet();
      log(pet.imageUrl);
      if (pet.imageUrl.contains('mp4')) {
        final controller = VideoPlayerController.network(pet.imageUrl);
        await controller.initialize();
        await controller.play();
        await controller.setLooping(true);

        emit(PetLoaded(pet: pet, controller: controller));
      } else {
        emit(PetLoaded(pet: pet));
      }
    } on Failure catch (error) {
      emit(PetException(failure: error));
    }
  }

  void _onSavePetEvent(SavePetEvent event, Emitter<HomeState> emit) async {
    await petRepository
        .saveImageToLocalDatabase(Pet(imageUrl: event.pet.imageUrl));
    emit(PetSaved());
    emit(PetLoaded(pet: event.pet));
  }
}
