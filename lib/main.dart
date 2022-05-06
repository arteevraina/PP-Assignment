import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_perfect/home/presentation/home_page.dart';
import 'package:pet_perfect/home/repositories/pet_repository.dart';

import 'home/data/pet.dart';
import 'posts/repositories/posts_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(PetAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PetRepositoryAPI>(
          create: (context) => PetRepositoryAPI(dioClient: Dio()),
        ),
        RepositoryProvider<PostsRepositoryAPI>(
          create: (context) => PostsRepositoryAPI(dioClient: Dio()),
        ),
      ],
      child: const MaterialApp(
        title: 'Pet Perfect',
        home: HomePage(),
      ),
    );
  }
}
