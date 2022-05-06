import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/posts/presentation/bloc/posts_bloc.dart';
import '/posts/repositories/posts_repository.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);
  static get route => MaterialPageRoute(builder: (_) => const PostsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostsBloc(postsRepository: context.read<PostsRepositoryAPI>())
            ..add(FetchPostsEvent()),
      child: const PostsPageView(),
    );
  }
}

class PostsPageView extends StatelessWidget {
  const PostsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<PostsBloc, PostsState>(
                  builder: (context, state) {
                    if (state is FetchingPosts) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PostsException) {
                      return Center(
                        child: Text(state.failure.message),
                      );
                    } else if (state is PostsLoaded) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(state.posts[index].title),
                              subtitle: Text(state.posts[index].body),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8.0);
                        },
                        itemCount: state.posts.length,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
