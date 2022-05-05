import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect/core/failure.dart';
import 'package:pet_perfect/home/data/pet.dart';
import 'package:pet_perfect/home/repositories/pet_repository.dart';
import 'package:video_player/video_player.dart';

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
      log(pet.imageUrl);
      if (pet.imageUrl.contains('mp4')) {
        final controller = VideoPlayerController.network(pet.imageUrl);
        await controller.initialize();
        await controller.play();

        emit(PetVideoLoaded(pet: pet, controller: controller));
      } else {
        emit(PetLoaded(pet: pet));
      }
    } on Failure catch (error) {
      emit(PetException(failure: error));
    }
  }
}
