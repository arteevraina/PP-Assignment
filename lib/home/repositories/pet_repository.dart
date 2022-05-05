import 'package:dio/dio.dart';
import 'package:pet_perfect/home/data/pet.dart';

abstract class PetRepository {
  Future<Pet> getPet();
}

class PetRepositoryAPI implements PetRepository {
  final Dio dioClient;

  PetRepositoryAPI({required this.dioClient});

  @override
  Future<Pet> getPet() {
    // TODO: implement getPet
    throw UnimplementedError();
  }
}
