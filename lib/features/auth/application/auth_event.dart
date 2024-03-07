part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStartedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ToggleUserLanguage extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ConstructBottomNavigationFlags extends AuthEvent {
  @override
  List<Object?> get props => [];

  const ConstructBottomNavigationFlags();
}

class AuthEvents {
  static void onAppStartedEvent(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AppStartedEvent());
  }

  static void toggleUserLanguage(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(ToggleUserLanguage());
  }
}
