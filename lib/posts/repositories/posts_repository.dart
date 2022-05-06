import 'package:dio/dio.dart';

import '/core/failure.dart';
import '/posts/data/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts();
}

class PostsRepositoryAPI implements PostsRepository {
  final Dio dioClient;

  PostsRepositoryAPI({required this.dioClient});

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
