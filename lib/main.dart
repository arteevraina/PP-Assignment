import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '/home/presentation/home_page.dart';
import '/home/repositories/pet_repository.dart';
import 'home/data/pet.dart';
import 'posts/repositories/posts_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(PetAdapter());
  final dioClient = Dio();
  await Hive.openBox<Pet>("Pet");
  runApp(MyApp(dioClient: dioClient));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.dioClient}) : super(key: key);

  final Dio dioClient;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PetRepositoryAPI>(
          create: (context) => PetRepositoryAPI(dioClient: dioClient),
        ),
        RepositoryProvider<PostsRepositoryAPI>(
          create: (context) => PostsRepositoryAPI(dioClient: dioClient),
        ),
      ],
      child: const MaterialApp(
        title: 'Pet Perfect',
        home: HomePage(),
      ),
    );
  }
}
