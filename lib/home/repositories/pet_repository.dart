import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '/core/failure.dart';
import '/home/data/pet.dart';

abstract class PetRepository {
  Future<Pet> getPet();
  Future<void> saveImageToLocalDatabase(Pet pet);
}

class PetRepositoryAPI implements PetRepository {
  final Dio dioClient;
  final String name = "Pet";

  PetRepositoryAPI({required this.dioClient});

  @override
  Future<Pet> getPet() async {
    try {
      final response = await dioClient.get('https://random.dog/woof.json');

      return Pet.fromJson(response.data);
    } on DioError catch (error) {
      throw Failure.fromDioError(error);
    }
  }

  @override
  Future<void> saveImageToLocalDatabase(Pet pet) async {
    var box = await Hive.openBox<Pet>(name);
    await box.add(pet);
  }
}
