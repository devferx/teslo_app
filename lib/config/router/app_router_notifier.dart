import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter/widgets.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';

part 'app_router_notifier.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouterNotifier> goRouterNotifier(GoRouterNotifierRef ref) {
  return GoRouterNotifier(ref);
}

class GoRouterNotifier extends ChangeNotifier {
  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(GoRouterNotifierRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.authStatus != _authStatus) {
        _authStatus = next.authStatus;
        notifyListeners();
      }
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
