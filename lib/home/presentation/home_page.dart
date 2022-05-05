import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/home/presentation/bloc/home_bloc.dart';
import 'package:pet_perfect/home/repositories/pet_repository.dart';
import 'package:pet_perfect/posts/presentation/posts_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(petRepository: context.read<PetRepositoryAPI>())
            ..add(FetchPetEvent()),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Perfect Assignment'),
      ),
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is PetLoading) {
              return const CircularProgressIndicator();
            } else if (state is PetException) {
              return Text(state.failure.message);
            } else if (state is PetLoaded) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(state.pet.imageUrl),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return (state is PetLoaded)
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, PostsPage.route);
                  },
                  child: const Icon(Icons.download),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
