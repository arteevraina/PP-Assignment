import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/failure.dart';
import '/posts/data/post.dart';
import '/posts/repositories/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;
  PostsBloc({required this.postsRepository}) : super(FetchingPosts()) {
    on<FetchPostsEvent>(_onFetchPostsEvent);
  }

  void _onFetchPostsEvent(PostsEvent event, Emitter<PostsState> emit) async {
    try {
      final posts = await postsRepository.getPosts();
      emit(PostsLoaded(posts: posts));
    } on Failure catch (error) {
      emit(PostsException(failure: error));
    }
  }
}
