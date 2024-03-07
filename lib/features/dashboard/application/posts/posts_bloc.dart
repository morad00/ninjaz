import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz/common/router/navigation_service.dart';
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
      (r) => emit(
        state.copyWith(
          isLoadingTab: false,
          postsList: event.loadMore ? state.postsList + r.data : r.data,
        ),
      ),
    );
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
      final failureOrSuccess = await _repo.getAllPosts(pageIndex: 0);
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
        (r) => emit(
          state.copyWith(
            isLoadingTab: false,
            postsList: r.data,
          ),
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
