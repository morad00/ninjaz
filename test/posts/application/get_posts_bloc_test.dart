import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ninjaz/common/data/realm/post_database.dart';
import 'package:ninjaz/common/router/navigation_service.dart';
import 'package:ninjaz/features/connection_status/applicataion/connection_status_bloc.dart';
import 'package:ninjaz/features/dashboard/application/posts/posts_bloc.dart';
import 'package:ninjaz/features/dashboard/domain/i_posts_repo.dart';
import 'package:ninjaz/features/dashboard/domain/model/posts_model.dart';

import 'get_posts_bloc_test.mocks.dart';

@GenerateMocks([IPostsRepo, NavigationService, ConnectionStatusBloc, RealmDatabase])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MockIPostsRepo mockIPostsRepo = MockIPostsRepo();
  MockNavigationService mockNavigationService = MockNavigationService();
  MockConnectionStatusBloc mockConnectionStatusBloc = MockConnectionStatusBloc();
  MockRealmDatabase mockRealmDatabase = MockRealmDatabase();

  final PostsState state = PostsState.initial();
  final int pageIndex = 0;
  PostsListModel successFullPostsListModel = PostsListModel(
    data: [
      PostsListData(
        id: "60d21b4667d0d8992e610c85",
        image: "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg",
        likes: 43,
        tags: ["animal", "dog", "golden retriever"],
        text: "adult Labrador retriever",
        publishDate: DateTime.parse("2020-05-24T14:53:17.598Z"),
        owner: Owner(
          id: "60d0fe4f5311236168a109ca",
          title: "ms.",
          firstName: "Sara",
          lastName: "Andersen",
          picture: "https://randomuser.me/api/portraits/women/58.jpg",
        ),
      ),
    ],
    total: 873,
    page: 0,
    limit: 10,
  );

  PostsListModel successFullLoadMorePostsListModel = PostsListModel(
    data: [
      PostsListData(
        id: "60d21b4667d0d8992e610c85",
        image: "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg",
        likes: 43,
        tags: ["animal", "dog", "golden retriever"],
        text: "adult Labrador retriever",
        publishDate: DateTime.parse("2020-05-24T14:53:17.598Z"),
        owner: Owner(
          id: "60d0fe4f5311236168a109ca",
          title: "ms.",
          firstName: "Sara",
          lastName: "Andersen",
          picture: "https://randomuser.me/api/portraits/women/58.jpg",
        ),
      ),
      PostsListData(
        id: "60d21b4967d0d8992e610c90",
        image: "https://img.dummyapi.io/photo-1510414696678-2415ad8474aa.jpg",
        likes: 31,
        tags: ["snow", "ice", "mountain"],
        text: "ice caves in the wild landscape photo of ice near ...",
        publishDate: DateTime.parse("2020-05-24T07:44:17.738Z"),
        owner: Owner(
          id: "60d0fe4f5311236168a10a0b",
          title: "miss",
          firstName: "Margarita",
          lastName: "Vicente",
          picture: "https://randomuser.me/api/portraits/med/women/5.jpg",
        ),
      ),
    ],
    total: 873,
    page: 1,
    limit: 10,
  );

  group('Successful Getting Posts', () {
    blocTest<PostsBloc, PostsState>(
      'Successful Getting posts list for the first time',
      setUp: () {
        when(mockConnectionStatusBloc.state).thenAnswer((_) => const Connected());
        when(mockIPostsRepo.getAllPosts(pageIndex: pageIndex)).thenAnswer((_) async {
          return Right(successFullPostsListModel);
        });
      },
      build: () => PostsBloc(
        mockIPostsRepo,
        state,
        mockNavigationService,
        mockConnectionStatusBloc,
        mockRealmDatabase,
      ),
      act: (bloc) => bloc.add(
        GetPosts(
          isLoadingTab: true,
          pageIndex: pageIndex,
          loadMore: false,
        ),
      ),
      expect: () => <PostsState>[
        state.copyWith(
          isLoadingTab: true,
        ),
        state.copyWith(
          isLoadingTab: false,
          postsList: successFullPostsListModel.data,
        ),
      ],
    );
  });

  group('Successful Refresh Posts', () {
    blocTest<PostsBloc, PostsState>(
      'Successful refresh posts list',
      setUp: () {
        when(mockConnectionStatusBloc.state).thenAnswer((_) => const Connected());
        when(mockIPostsRepo.getAllPosts(pageIndex: pageIndex)).thenAnswer((_) async {
          return Right(successFullPostsListModel);
        });
      },
      build: () => PostsBloc(
        mockIPostsRepo,
        state,
        mockNavigationService,
        mockConnectionStatusBloc,
        mockRealmDatabase,
      ),
      act: (bloc) => bloc.add(const RefreshPostsList()),
      expect: () => <PostsState>[
        state.copyWith(
          postsPageIndex: 0,
          isLoadingTab: true,
          postsList: [],
        ),
        state.copyWith(
          isLoadingTab: false,
          postsList: successFullPostsListModel.data,
        ),
      ],
    );
  });

  group('Successful Load more Posts', () {
    blocTest<PostsBloc, PostsState>(
      'Successful Load more posts',
      setUp: () {
        when(mockConnectionStatusBloc.state).thenAnswer((_) => const Connected());
        when(mockIPostsRepo.getAllPosts(pageIndex: pageIndex + 1)).thenAnswer((_) async {
          return Right(successFullLoadMorePostsListModel);
        });
      },
      build: () => PostsBloc(
        mockIPostsRepo,
        state,
        mockNavigationService,
        mockConnectionStatusBloc,
        mockRealmDatabase,
      ),
      act: (bloc) => bloc.add(LoadMorePosts(pageIndex: pageIndex + 1)),
      expect: () => <PostsState>[
        state.copyWith(
          postsPageIndex: 1,
          isLoadingTab: false,
          postsList: [],
        ),
        state.copyWith(
          postsPageIndex: 1,
          isLoadingTab: false,
          postsList: successFullLoadMorePostsListModel.data,
        ),
      ],
    );
  });
}
