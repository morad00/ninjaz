import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz/common/data/realm/post_database.dart';
import 'package:ninjaz/common/router/navigation_service.dart';
import 'package:ninjaz/features/connection_status/applicataion/connection_status_bloc.dart';
import 'package:ninjaz/features/dashboard/application/posts/posts_bloc.dart';
import 'package:ninjaz/features/dashboard/infrastructure/remote/posts_api.dart';
import 'package:ninjaz/features/dashboard/infrastructure/remote/posts_repo.dart';

class Blocs {
  static PostsBloc _postsBloc = PostsBloc(
    PostsRepo(PostsApi()),
    PostsState.initial(),
    NavigationService(),
    BlocProvider.of<ConnectionStatusBloc>(NavigationService().navigationKey.currentContext!),
    RealmDatabase(),
  );

  static PostsBloc postsBloc() {
    if (_postsBloc.isClosed) {
      _postsBloc = PostsBloc(
        PostsRepo(PostsApi()),
        PostsState.initial(),
        NavigationService(),
        BlocProvider.of<ConnectionStatusBloc>(NavigationService().navigationKey.currentContext!),
        RealmDatabase(),
      );
      return _postsBloc;
    } else {
      return _postsBloc;
    }
  }
}
