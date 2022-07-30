import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../app.dart';
import '../entities/family.dart';
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
            // onPressed: () => const PersonRoute('f1', 1).push(context),
            onPressed: () => context.push('/family/f1/person/1'),
            child: const Text('Push a route'),
          ),
          const _LogoutButton(),
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
    final authUser = ref.watch(authUserProvider);
    return authUser != null
        ? IconButton(
            onPressed: () => ref.read(logout)(),
            tooltip: 'Logout: ${authUser.name}',
            icon: const Icon(Icons.logout),
          )
        : const SizedBox();
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
                // onTap: () => FamilyRoute(f.id).go(context),
                onTap: () => context.go('/family/${f.id}'),
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
