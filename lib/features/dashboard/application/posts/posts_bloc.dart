import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz/common/data/realm/post_database.dart';
import 'package:ninjaz/common/data/realm/realm_post.dart';
import 'package:ninjaz/common/router/navigation_service.dart';
import 'package:ninjaz/features/connection_status/applicataion/connection_status_bloc.dart';
import 'package:ninjaz/features/dashboard/domain/i_posts_repo.dart';
import 'package:ninjaz/features/dashboard/domain/model/posts_model.dart';
import 'package:ninjaz/features/dashboard/domain/posts_failures.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final IPostsRepo _repo;
  final PostsState initialState;
  final NavigationService navigationService;

  PostsBloc(this._repo, this.initialState, this.navigationService) : super(initialState) {
    on<GetPosts>(_onGetPosts);
    on<RefreshPostsList>(_onRefreshPostsList);
    on<LoadMorePosts>(_onLoadMorePosts);
  }

  FutureOr<void> _onGetPosts(GetPosts event, Emitter<PostsState> emit) async {
    emit(
      state.copyWith(
        isLoadingTab: event.isLoadingTab,
        postsPageIndex: event.pageIndex,
      ),
    );
    if (BlocProvider.of<ConnectionStatusBloc>(navigationService.navigationKey.currentContext!).state is DisConnected) {
      List<PostsListData> offlinePosts = [];
      final res = await RealmDatabase.getPosts();
      if (res.isNotEmpty) {
        offlinePosts = res.map((postItem) {
          return PostsListData(
            id: postItem.id,
            likes: postItem.likesCount,
            publishDate: postItem.publishDate,
            image: postItem.imageUrl,
            tags: postItem.tags,
            text: postItem.text,
            owner: Owner(
              id: postItem.ownerId,
              title: postItem.ownerTitle,
              firstName: postItem.ownerFirstName,
              lastName: postItem.ownerLastName,
              picture: postItem.ownerPicture,
            ),
          );
        }).toList();
      }
      emit(
        state.copyWith(
          isLoadingTab: false,
          postsList: offlinePosts,
          showErrorPage: false,
        ),
      );
    } else {
      final failureOrSuccess = await _repo.getAllPosts(
        pageIndex: event.pageIndex,
      );
      failureOrSuccess.fold(
        (l) async {
          if (l == PostsFailures.networkError) {
            emit(
              state.copyWith(
                isLoadingTab: false,
                showErrorPage: true,
              ),
            );
          }
        },
        (r) async {
          emit(
            state.copyWith(
              isLoadingTab: false,
              postsList: event.loadMore ? state.postsList + r.data : r.data,
            ),
          );
          final realmPosts = r.data
              .map((post) => PostItem(
                    post.id,
                    post.text,
                    post.image,
                    post.publishDate,
                    post.likes,
                    post.owner.id,
                    post.owner.title,
                    post.owner.firstName,
                    post.owner.lastName,
                    post.owner.picture,
                    tags: post.tags,
                  ))
              .toList();
          await RealmDatabase.savePosts(realmPosts);
        },
      );
    }
  }

  FutureOr<void> _onRefreshPostsList(RefreshPostsList event, Emitter<PostsState> emit) async {
    if (state.isLoadingTab) {
    } else {
      emit(
        state.copyWith(
          postsPageIndex: 0,
          isLoadingTab: true,
          postsList: [],
        ),
      );
      add(
        const GetPosts(
          loadMore: true,
          pageIndex: 0,
        ),
      );
    }

    state.tabRefreshController.refreshCompleted();
  }

  FutureOr<void> _onLoadMorePosts(LoadMorePosts event, Emitter<PostsState> emit) async {
    if (state.isLoadingTab) {
    } else {
      add(
        GetPosts(
          loadMore: true,
          pageIndex: state.postsPageIndex + 1,
        ),
      );
    }

    state.tabRefreshController.loadComplete();
  }
}
