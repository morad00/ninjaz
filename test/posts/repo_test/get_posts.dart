import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ninjaz/features/dashboard/domain/i_posts_api.dart';
import 'package:ninjaz/features/dashboard/domain/i_posts_repo.dart';
import 'package:ninjaz/features/dashboard/domain/model/posts_model.dart';
import 'package:ninjaz/features/dashboard/domain/posts_failures.dart';
import 'package:ninjaz/features/dashboard/infrastructure/remote/posts_repo.dart';

import 'get_posts.mocks.dart';

@GenerateMocks([IPostsApi])
void main() {
  MockIPostsApi mockIPostsApi = MockIPostsApi();
  IPostsRepo postsRepo = PostsRepo(mockIPostsApi);
  int pageIndex = 0;

  group('get Posts test', () {
    final requestOptions = RequestOptions(path: '');
    test('Successful get Posts test', () async {
      PostsListModel postsListModel = PostsListModel(
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

      Response apiResponse = Response(
        requestOptions: requestOptions,
        data: {
          "data": [
            {
              "id": "60d21b4667d0d8992e610c85",
              "image": "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg",
              "likes": 43,
              "tags": ["animal", "dog", "golden retriever"],
              "text": "adult Labrador retriever",
              "publishDate": "2020-05-24T14:53:17.598Z",
              "owner": {
                "id": "60d0fe4f5311236168a109ca",
                "title": "ms.",
                "firstName": "Sara",
                "lastName": "Andersen",
                "picture": "https://randomuser.me/api/portraits/women/58.jpg"
              }
            }
          ],
          "total": 873,
          "page": 0,
          "limit": 10
        },
      );
      when(mockIPostsApi.getPostsList(pageIndex: pageIndex)).thenAnswer((_) async => apiResponse);
      final repoCallResult = await postsRepo.getAllPosts(pageIndex: pageIndex);
      expect(
        repoCallResult,
        equals(
          Right<PostsFailures, PostsListModel>(postsListModel),
        ),
      );
    });

    test('Failed get posts test and returns network error', () async {
      when(mockIPostsApi.getPostsList(pageIndex: pageIndex)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );
      final repoCallResult = await postsRepo.getAllPosts(pageIndex: pageIndex);
      expect(
        repoCallResult,
        equals(
          const Left<PostsFailures, PostsListModel>(PostsFailures.networkError),
        ),
      );
    });

    test('Failed get posts test and returns empty list', () async {
      const int veryLargeIndex = 200;
      Response apiResponse = Response(
        requestOptions: requestOptions,
        data: {
          "data": [],
          "total": 873,
          "page": 200,
          "limit": 10
        },
      );
      when(mockIPostsApi.getPostsList(pageIndex: veryLargeIndex)).thenAnswer((_) async => apiResponse);
      final repoCallResult = await postsRepo.getAllPosts(pageIndex: veryLargeIndex);
      expect(
        repoCallResult,
        equals(
          const Left<PostsFailures, PostsListModel>(PostsFailures.emptyList),
        ),
      );
    });
  });
}
