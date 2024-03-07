import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationState.initial()) {
    on<NavigateToTab>(_onNavigateToTab);
  }

  FutureOr<void> _onNavigateToTab(NavigateToTab event, Emitter<BottomNavigationState> emit) {
    emit(
      state.copyWith(
        currentTabIndex: event.tabIndex,
      ),
    );
    state.tabsController.jumpToPage(event.tabIndex);
  }
}
