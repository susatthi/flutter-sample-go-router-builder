import 'family.dart';

enum PersonDetails {
  hobbies,
  favoriteFood,
  favoriteSport,
  ;

  static PersonDetails valueOf(String? name) =>
      PersonDetails.values.firstWhere((details) => details.name == name);
}

class Person {
  Person({
    required this.id,
    required this.name,
    required this.age,
    this.details = const <PersonDetails, String>{},
  });

  final int id;
  final String name;
  final int age;

  final Map<PersonDetails, String> details;
}

class FamilyPerson {
  FamilyPerson({required this.family, required this.person});

  final Family family;
  final Person person;
}
