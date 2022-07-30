import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/auth_user.dart';
import '../../repositories/auth_repository.dart';

final authUserProvider = Provider<AuthUser?>(
  (ref) {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.authUser;
  },
);

final login = Provider(
  (ref) {
    final read = ref.read;
    return (String userName) {
      read(authRepositoryProvider).login(userName);
      read(authUserStateNotifierProvider).loggedIn = true;
    };
  },
);

final logout = Provider(
  (ref) {
    final read = ref.read;
    return () {
      read(authRepositoryProvider).logout();
      read(authUserStateNotifierProvider).loggedIn = false;
    };
  },
);

final authUserStateNotifierProvider = ChangeNotifierProvider(
  (_) => AuthUserStateNotifier(),
);

class AuthUserStateNotifier extends ChangeNotifier {
  AuthUserStateNotifier();

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  set loggedIn(bool newValue) {
    _loggedIn = newValue;
    if (!_loggedIn) {
      notifyListeners();
    }
  }
}
