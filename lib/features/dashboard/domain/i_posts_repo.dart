import 'package:dartz/dartz.dart';
import 'package:ninjaz/features/dashboard/domain/i_posts_api.dart';
import 'package:ninjaz/features/dashboard/domain/model/posts_model.dart';
import 'package:ninjaz/features/dashboard/domain/posts_failures.dart';

abstract class IPostsRepo {
  IPostsApi _api;

  IPostsRepo(this._api);

  Future<Either<PostsFailures, PostsListModel>> getAllPosts({required int pageIndex});
}
