part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class GetPosts extends PostsEvent {
  final int pageIndex;
  final bool loadMore;
  final bool? isLoadingTab;

  @override
  List<Object?> get props => [
        pageIndex,
        loadMore,
        isLoadingTab,
      ];

  const GetPosts({
    required this.pageIndex,
    required this.loadMore,
    this.isLoadingTab,
  });
}

class RefreshPostsList extends PostsEvent {
  const RefreshPostsList();

  @override
  List<Object?> get props => [];
}

class LoadMorePosts extends PostsEvent {
  const LoadMorePosts({required this.pageIndex});

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}

class PostsEvents {
  static void getPosts(
    BuildContext context, {
    required int pageIndex,
    required bool loadMore,
    bool? isLoadingTab,
  }) {
    BlocProvider.of<PostsBloc>(context).add(
      GetPosts(
        pageIndex: pageIndex,
        loadMore: loadMore,
        isLoadingTab: isLoadingTab,
      ),
    );
  }

  static void refreshPostsList(BuildContext context) {
    BlocProvider.of<PostsBloc>(context).add(const RefreshPostsList());
  }

  static void loadMorePosts(BuildContext context, {required int pageIndex}) {
    BlocProvider.of<PostsBloc>(context).add(LoadMorePosts(pageIndex: pageIndex));
  }
}
