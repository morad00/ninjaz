import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ninjaz/features/dashboard/domain/model/posts_model.dart';
import 'package:ninjaz/features/dashboard/domain/posts_failures.dart';
import 'package:ninjaz/features/dashboard/infrastructure/remote/posts_api.dart';

class PostsRepo {
  final PostsApi _api = PostsApi();

  Future<Either<PostsFailures, PostsListModel>> getAllPosts({required int pageIndex}) async {
    try {
      final response = await _api.getPostsList(pageIndex: pageIndex);
      final postsListModel = postsListModelFromJson(jsonEncode(response.data));
      return right(postsListModel);
    } on DioException catch (_) {
      return left(PostsFailures.networkError);
    }
  }
}
