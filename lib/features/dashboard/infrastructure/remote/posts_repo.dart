import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ninjaz/features/dashboard/domain/i_posts_api.dart';
import 'package:ninjaz/features/dashboard/domain/i_posts_repo.dart';
import 'package:ninjaz/features/dashboard/domain/model/posts_model.dart';
import 'package:ninjaz/features/dashboard/domain/posts_failures.dart';

class PostsRepo extends IPostsRepo {
  final IPostsApi _api;

  PostsRepo(this._api) : super(_api);

  @override
  Future<Either<PostsFailures, PostsListModel>> getAllPosts({required int pageIndex}) async {
    try {
      final response = await _api.getPostsList(pageIndex: pageIndex);
      final postsListModel = postsListModelFromJson(jsonEncode(response.data));
      if (postsListModel.data.isEmpty) {
        return left(PostsFailures.emptyList);
      } else {
        return right(postsListModel);
      }
    } on DioException catch (_) {
      return left(PostsFailures.networkError);
    }
  }
}
