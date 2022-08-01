import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/person.dart';
import 'components/async_value_handler.dart';
import 'components/persons.dart';

class PersonDetailsPage extends StatelessWidget {
  const PersonDetailsPage({
    super.key,
    required this.fid,
    required this.pid,
    required this.details,
    this.extra,
  });

  final String fid;
  final int pid;
  final PersonDetails details;
  final int? extra;

  static const name = 'person-details-page';

  @override
  Widget build(BuildContext context) {
    final parameter = PersonParameter(fid: fid, pid: pid);
    return Scaffold(
      appBar: AppBar(title: _Title(parameter: parameter)),
      body: _ListView(
        parameter: parameter,
        details: details,
        extra: extra,
      ),
    );
  }
}

class _Title extends ConsumerWidget {
  const _Title({
    required this.parameter,
  });

  final PersonParameter parameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<FamilyPerson>(
      value: ref.watch(personProvider(parameter)),
      builder: (familyPerson) => Text(familyPerson.person.name),
    );
  }
}

class _ListView extends ConsumerWidget {
  const _ListView({
    required this.parameter,
    required this.details,
    this.extra,
  });

  final PersonParameter parameter;
  final PersonDetails details;
  final int? extra;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<FamilyPerson>(
      value: ref.watch(personProvider(parameter)),
      builder: (familyPerson) {
        final family = familyPerson.family;
        final person = familyPerson.person;
        return ListView(
          children: [
            ListTile(
              title: Text(
                '${person.name} ${family.name}: '
                '$details - ${person.details[details]}',
              ),
            ),
            if (extra == null) const ListTile(title: Text('No extra click!')),
            if (extra != null)
              ListTile(title: Text('Extra click count: $extra')),
          ],
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
