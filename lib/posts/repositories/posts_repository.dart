import 'package:dio/dio.dart';
import 'package:pet_perfect/core/failure.dart';
import 'package:pet_perfect/posts/data/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts();
}

class PostRepositoryAPI implements PostsRepository {
  final Dio dioClient;

  PostRepositoryAPI({required this.dioClient});

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
