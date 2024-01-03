import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

part 'auth_provider.g.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

@riverpod
class Auth extends _$Auth {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await _authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout('Credenciales no son correctas');
    } on TimeoutException {
      logout('Timeout');
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {}

  Future<void> logout([String? errorMessage]) async {
    // TODO: remove the token
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  void _setLoggedUser(User user) {
    // TODO: save the token
    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user,
    );
  }
}
