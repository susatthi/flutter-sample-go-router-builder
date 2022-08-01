import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/auth_user.dart';
import '../../repositories/auth_repository.dart';

final _authUserStreamProvider = StreamProvider<AuthUser?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return authRepository.changes();
  },
);

final authUserProvider = FutureProvider<AuthUser?>(
  (ref) {
    ref.listen<AsyncValue<AuthUser?>>(
      _authUserStreamProvider,
      (previous, next) {
        // Streamを監視して都度反映する
        ref.state = next;
      },
    );

    // 初回は最新データを返す
    final authRepository = ref.watch(authRepositoryProvider);
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

final updateUserName = Provider(
  (ref) {
    final read = ref.read;
    return (String userName) {
      read(authRepositoryProvider).update(userName);
    };
  },
);
