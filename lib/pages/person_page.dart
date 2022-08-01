import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/person.dart';
import '../router.dart';
import 'components/async_value_handler.dart';
import 'components/persons.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({
    super.key,
    required this.fid,
    required this.pid,
  });

  final String fid;
  final int pid;

  static const name = 'person-page';

  @override
  Widget build(BuildContext context) {
    final parameter = PersonParameter(fid: fid, pid: pid);
    return Scaffold(
      appBar: AppBar(title: _Title(parameter: parameter)),
      body: _ListView(parameter: parameter),
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
  });

  final PersonParameter parameter;

  static int _extraClickCount = 0;

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
                '${person.name} ${family.name} is ${person.age} years old',
              ),
            ),
            for (MapEntry<PersonDetails, String> entry
                in person.details.entries)
              ListTile(
                title: Text(
                  '${entry.key.name} - ${entry.value}',
                ),
                trailing: OutlinedButton(
                  onPressed: () => PersonDetailsRoute(
                    family.id,
                    person.id,
                    details: entry.key.name,
                    $extra: ++_extraClickCount,
                  ).go(context),
                  child: const Text('With extra...'),
                ),
                onTap: () => PersonDetailsRoute(
                  family.id,
                  person.id,
                  details: entry.key.name,
                ).go(context),
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
