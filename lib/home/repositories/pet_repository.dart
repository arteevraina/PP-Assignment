import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '/core/failure.dart';
import '/home/data/pet.dart';

/// Abstract Repository to handle data layer operations related to Pet.
abstract class PetRepository {
  Future<Pet> getPet();
  Future<void> saveImageToLocalDatabase(Pet pet);
}

/// Implementation of [PetRepository] to handle data layer operations related to Pet.
class PetRepositoryAPI implements PetRepository {
  final Dio dioClient;
  final String name = "Pet";

  /// Constructor to initialize [dioClient].
  PetRepositoryAPI({required this.dioClient});

  /// Fetches pet from remote server.
  /// If there is an error, it throws [Failure] with [DioError] as failure.
  @override
  Future<Pet> getPet() async {
    try {
      final response = await dioClient.get('https://random.dog/woof.json');

      return Pet.fromJson(response.data);
    } on DioError catch (error) {
      throw Failure.fromDioError(error);
    }
  }

  /// Saves pet to local database.
  @override
  Future<void> saveImageToLocalDatabase(Pet pet) async {
    final hiveBox = Hive.box<Pet>('Pet');
    await hiveBox.add(pet);
  }
}
