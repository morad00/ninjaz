part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final bool isLoadingTab;
  final bool showErrorPage;
  final int postsPageIndex;
  final bool isHorizontal;
  final RefreshController tabRefreshController;
  final List<PostsListData> postsList;

  @override
  List<Object> get props => [
        isLoadingTab,
        showErrorPage,
        postsPageIndex,
        isHorizontal,
        tabRefreshController,
        postsList,
      ];

  const PostsState({
    required this.isLoadingTab,
    required this.showErrorPage,
    required this.postsPageIndex,
    required this.isHorizontal,
    required this.tabRefreshController,
    required this.postsList,
  });

  factory PostsState.initial() => PostsState(
        isLoadingTab: false,
        showErrorPage: false,
        postsPageIndex: 0,
        isHorizontal: false,
        tabRefreshController: RefreshController(),
        postsList: const [],
      );

  PostsState copyWith({
    bool? isLoadingTab,
    bool? showErrorPage,
    int? postsPageIndex,
    bool? isHorizontal,
    RefreshController? tabRefreshController,
    List<PostsListData>? postsList,
  }) {
    return PostsState(
      isLoadingTab: isLoadingTab ?? this.isLoadingTab,
      showErrorPage: showErrorPage ?? this.showErrorPage,
      postsPageIndex: postsPageIndex ?? this.postsPageIndex,
      isHorizontal: isHorizontal ?? this.isHorizontal,
      tabRefreshController: tabRefreshController ?? this.tabRefreshController,
      postsList: postsList ?? this.postsList,
    );
  }
}
