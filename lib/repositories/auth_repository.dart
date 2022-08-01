import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/auth_user.dart';

final authRepositoryProvider = Provider(
  (ref) {
    final repository = AuthRepository();
    ref.onDispose(repository.dispose);
    return repository;
  },
);

class AuthRepository {
  AuthUser? _authUser;
  AuthUser? get authUser => _authUser;
  bool get loggedIn => _authUser != null;
  final _changesController = StreamController<AuthUser?>.broadcast();

  void dispose() {
    _changesController.close();
  }

  Stream<AuthUser?> changes() => _changesController.stream;

  void login(String userName) {
    _authUser = AuthUser(name: userName);
    _changesController.add(_authUser);
  }

  void logout() {
    _authUser = null;
    _changesController.add(_authUser);
  }

  void update(String userName) {
    _authUser = AuthUser(name: userName);
    _changesController.add(_authUser);
  }
}
