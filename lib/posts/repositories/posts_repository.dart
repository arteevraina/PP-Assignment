import 'package:dio/dio.dart';

import '/core/failure.dart';
import '/posts/data/post.dart';

/// Abstract Repository to handle data layer operations related to Post.
abstract class PostsRepository {
  Future<List<Post>> getPosts();
}

/// Implementation of [PostsRepository] to handle data layer operations related to Post.
/// This implementation uses Dio to fetch posts from remote server.
class PostsRepositoryAPI implements PostsRepository {
  final Dio dioClient;

  /// Constructor to initialize [dioClient].
  PostsRepositoryAPI({required this.dioClient});

  /// Fetches posts from remote server.
  /// If there is an error, it throws [Failure] with [DioError] as failure.
  @override
  Future<List<Post>> getPosts() async {
    try {
      final List<Post> result = [];
      final response =
          await dioClient.get('http://jsonplaceholder.typicode.com/posts');

      for (var item in response.data) {
        result.add(Post.fromJson(item));
      }

      return result;
    } on DioError catch (error) {
      throw Failure.fromDioError(error);
    }
  }
}
