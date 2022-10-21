import 'dart:convert';
import 'dart:developer';
import 'package:flutter_networks/model/comment_model.dart';
import 'package:flutter_networks/model/post_model.dart';
import 'package:http/http.dart' as http;

class NetworkSrc {
  //? kop responslarni olish uchun
  static final client = http.Client();
  static Future<List<PostModel>> getPostsUsingGetMethodWithClient() async {
    try {
      var response = await client.get(Uri.https(_Urls.baseUrl, _Urls.posts));
      if (response.statusCode == 200) {
        var ltData = jsonDecode(utf8.decode(response.bodyBytes));
        return List<PostModel>.from(ltData.map((e) => PostModel.fromJson(e)));
      }
    } catch (e) {
      log(e.toString());
    } finally {
      client.close();
    }
    return [PostModel.fromJson({})];
  }

  static Future<List<PostModel>> getPostsUsingGetMethod() async {
    try {
      var uri = Uri.https(_Urls.baseUrl, _Urls.posts);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var ltData = jsonDecode(utf8.decode(response.bodyBytes));
        return List<PostModel>.from(ltData.map((e) => PostModel.fromJson(e)));
      }
    } catch (e) {
      log(e.toString());
    }
    return [PostModel.fromJson({})];
  }

  static Future<PostModel> getSinglePostsUsingGetMethod(
      {required int? postId}) async {
    try {
      var uri = Uri.https(
          _Urls.baseUrl, _Urls.singlePost(postId: postId!.toString())!);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return PostModel.fromJson(data);
      }
    } catch (e) {
      log(e.toString());
    }
    return PostModel.fromJson({});
  }

  static Future<List<CommentModel>> getSinglePostCommentsUsingGetMethod(
      {required int postId}) async {
    try {
      var uri =
          Uri.https(_Urls.baseUrl, _Urls.comments(postId: postId.toString())!);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(data.map((e) => CommentModel.fromJson(e)));
      }
    } catch (e) {
      log(e.toString());
    }
    return [CommentModel.fromJson({})];
  }
}

class _Urls {
  static const baseUrl = 'jsonplaceholder.typicode.com';
  static const posts = 'posts';
  static String? singlePost({required String postId}) => "posts/$postId";
  static String? comments({required String postId}) =>
      "${singlePost(postId: postId)}/comments";

  static String? commentsOther({required String postId}) =>
      "/comments?postId=$postId";
}
