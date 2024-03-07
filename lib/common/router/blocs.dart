import 'package:ninjaz/common/router/navigation_service.dart';
import 'package:ninjaz/features/dashboard/application/posts/posts_bloc.dart';
import 'package:ninjaz/features/dashboard/infrastructure/remote/posts_api.dart';
import 'package:ninjaz/features/dashboard/infrastructure/remote/posts_repo.dart';

class Blocs {
  static PostsBloc _postsBloc = PostsBloc(
    PostsRepo(PostsApi()),
    PostsState.initial(),
    NavigationService(),
  );

  static PostsBloc postsBloc() {
    if (_postsBloc.isClosed) {
      _postsBloc = PostsBloc(
        PostsRepo(PostsApi()),
        PostsState.initial(),
        NavigationService(),
      );
      return _postsBloc;
    } else {
      return _postsBloc;
    }
  }
}
