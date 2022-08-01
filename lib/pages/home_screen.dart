import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../app.dart';
import '../entities/auth_user.dart';
import '../entities/family.dart';
import '../router.dart';
import 'components/async_value_handler.dart';
import 'components/auth_user.dart';
import 'components/families.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(App.title),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () => const PersonRoute('f1', 1).push(context),
            child: const Text('Push a route'),
          ),
          const _LogoutButton(),
          const _UpdateUserNameButton(),
        ],
      ),
      body: const _ListView(),
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<AuthUser>(
      value: ref.watch(authUserProvider),
      builder: (authUser) {
        return IconButton(
          onPressed: () => ref.read(logout)(),
          tooltip: 'Logout: ${authUser.name}',
          icon: const Icon(Icons.logout),
        );
      },
    );
  }
}

class _UpdateUserNameButton extends ConsumerWidget {
  const _UpdateUserNameButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<AuthUser>(
      value: ref.watch(authUserProvider),
      builder: (authUser) {
        return IconButton(
          onPressed: () => ref.read(updateUserName)('updated-user'),
          icon: const Icon(Icons.update),
        );
      },
    );
  }
}

class _ListView extends ConsumerWidget {
  const _ListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<List<Family>>(
      value: ref.watch(familiesProvider),
      builder: (families) {
        return ListView(
          children: [
            for (final f in families)
              ListTile(
                title: Text(f.name),
                onTap: () => FamilyRoute(f.id).go(context),
              )
          ],
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
