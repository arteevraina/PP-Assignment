import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/home/presentation/home_page.dart';
import 'package:pet_perfect/home/repositories/pet_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Perfect',
      home: RepositoryProvider(
        create: (context) => PetRepositoryAPI(dioClient: Dio()),
        child: const HomePage(),
      ),
    );
  }
}
