part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class FetchingPosts extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;
  const PostsLoaded({required this.posts});
}

class PostsException extends PostsState {
  final Failure failure;
  const PostsException({required this.failure});
}
