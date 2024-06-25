import 'dart:convert';

import 'package:sm_project/api/dto/post_dto.dart';
import 'package:http/http.dart' as http;
import 'package:sm_project/api/requests/apis.dart';

class PostRequest {
  Future<Post> getPost(int id) async {
    final uri = Uri.parse("${Apis.post_api_url}/$id");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load post");
    }
  }

  Future<List<Post>> getPosts() async {
    final uri = Uri.parse(Apis.post_api_url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List myList = jsonDecode(response.body);
      List<Post> _allPosts = List.generate(
          myList.length, (index) => Post.fromJsonList(myList, index));
      return _allPosts;
    } else {
      throw Exception("failed to load posts");
    }
  }

  Future<List<Post>> getPostsByUserId() async {
    final uri =
        Uri.parse("https://jsonplaceholder.typicode.com/posts?userId=1");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List myList = jsonDecode(response.body);
      List<Post> _allPosts = List.generate(
          myList.length, (index) => Post.fromJsonList(myList, index));
      return _allPosts;
    } else {
      throw Exception("failed to load posts");
    }
  }
}
