import 'package:hive/hive.dart';

part 'pet.g.dart';

@HiveType(typeId: 0, adapterName: 'PetAdapter')
class Pet extends HiveObject {
  @HiveField(0)
  final String imageUrl;

  Pet({required this.imageUrl});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(imageUrl: json['url']);
  }
}
