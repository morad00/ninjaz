import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<AppStartedEvent>(_onAppStartedEvent);
  }

  FutureOr<void> _onAppStartedEvent(AppStartedEvent event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(
      state.copyWith(
        isSplashLoading: false,
      ),
    );
  }
}
