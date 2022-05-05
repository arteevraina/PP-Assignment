import 'package:dio/dio.dart';
import 'package:pet_perfect/core/failure.dart';
import 'package:pet_perfect/home/data/pet.dart';

abstract class PetRepository {
  Future<Pet> getPet();
}

class PetRepositoryAPI implements PetRepository {
  final Dio dioClient;

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
}
