import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app.dart';
import 'components/auth_user.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    super.key,
    this.from,
  });

  final String? from;

  static const name = 'login-page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(App.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(login)('test-user');
                if (from != null) {
                  context.go(from!);
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
