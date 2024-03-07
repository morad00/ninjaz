part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String currentLang;
  final bool isSplashLoading;

  const AuthState({
    required this.currentLang,
    required this.isSplashLoading,
  });

  @override
  List<Object?> get props => [
        currentLang,
        isSplashLoading,
      ];

  factory AuthState.initial() => const AuthState(
        currentLang: 'ar',
        isSplashLoading: true,
      );

  AuthState copyWith({
    String? currentLang,
    bool? isSplashLoading,
  }) {
    return AuthState(
      currentLang: currentLang ?? this.currentLang,
      isSplashLoading: isSplashLoading ?? this.isSplashLoading,
    );
  }
}
