import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.download),
      ),
    );
  }
}
