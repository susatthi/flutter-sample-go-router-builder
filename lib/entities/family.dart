import 'person.dart';

class Family {
  Family({
    required this.id,
    required this.name,
    required this.people,
  });

  final String id;
  final String name;
  final List<Person> people;

  Person person(int pid) => people.singleWhere(
        (Person p) => p.id == pid,
        orElse: () => throw Exception('unknown person $pid for family $id'),
      );
}
