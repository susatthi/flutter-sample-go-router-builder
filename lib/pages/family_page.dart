import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../entities/family.dart';
import '../entities/person.dart';
import '../router.dart';
import 'components/async_value_handler.dart';
import 'components/families.dart';

class FamilyPage extends ConsumerWidget {
  const FamilyPage({
    required this.fid,
    super.key,
  });

  final String fid;

  static const name = 'family-page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: _Title(fid: fid)),
      body: _ListView(fid: fid),
    );
  }
}

class _Title extends ConsumerWidget {
  const _Title({
    required this.fid,
  });

  final String fid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<Family>(
      value: ref.watch(familyProvider(fid)),
      builder: (family) => Text(family.name),
    );
  }
}

class _ListView extends ConsumerWidget {
  const _ListView({
    required this.fid,
  });

  final String fid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<Family>(
      value: ref.watch(familyProvider(fid)),
      builder: (family) => ListView(
        children: [
          for (final Person p in family.people)
            ListTile(
              title: Text(p.name),
              onTap: () => PersonRoute(family.id, p.id).go(context),
            ),
        ],
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
