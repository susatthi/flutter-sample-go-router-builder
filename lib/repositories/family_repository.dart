import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../entities/family.dart';
import '../entities/person.dart';

final familyRepositoryProvider = Provider(
  (_) => FamilyRepository(),
);

class FamilyRepository {
  static final Random rnd = Random();

  Future<List<Family>> getFamilies() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return _familyData;
  }

  Future<Family> getFamily(String fid) async =>
      (await getFamilies()).family(fid);

  Future<FamilyPerson> getPerson(String fid, int pid) async {
    final family = await getFamily(fid);
    return FamilyPerson(family: family, person: family.person(pid));
  }

  Family familyById(String fid) => _familyData.family(fid);

  final List<Family> _familyData = <Family>[
    Family(
      id: 'f1',
      name: 'Sells',
      people: <Person>[
        Person(
          id: 1,
          name: 'Chris',
          age: 52,
          details: <PersonDetails, String>{
            PersonDetails.hobbies: 'coding',
            PersonDetails.favoriteFood: 'all of the above',
            PersonDetails.favoriteSport: 'football?'
          },
        ),
        Person(id: 2, name: 'John', age: 27),
        Person(id: 3, name: 'Tom', age: 26),
      ],
    ),
    Family(
      id: 'f2',
      name: 'Addams',
      people: <Person>[
        Person(id: 1, name: 'Gomez', age: 55),
        Person(id: 2, name: 'Morticia', age: 50),
        Person(id: 3, name: 'Pugsley', age: 10),
        Person(id: 4, name: 'Wednesday', age: 17),
      ],
    ),
    Family(
      id: 'f3',
      name: 'Hunting',
      people: <Person>[
        Person(id: 1, name: 'Mom', age: 54),
        Person(id: 2, name: 'Dad', age: 55),
        Person(id: 3, name: 'Will', age: 20),
        Person(id: 4, name: 'Marky', age: 21),
        Person(id: 5, name: 'Ricky', age: 22),
        Person(id: 6, name: 'Danny', age: 23),
        Person(id: 7, name: 'Terry', age: 24),
        Person(id: 8, name: 'Mikey', age: 25),
        Person(id: 9, name: 'Davey', age: 26),
        Person(id: 10, name: 'Timmy', age: 27),
        Person(id: 11, name: 'Tommy', age: 28),
        Person(id: 12, name: 'Joey', age: 29),
        Person(id: 13, name: 'Robby', age: 30),
        Person(id: 14, name: 'Johnny', age: 31),
        Person(id: 15, name: 'Brian', age: 32),
      ],
    ),
  ];
}

extension on List<Family> {
  Family family(String fid) => singleWhere(
        (Family f) => f.id == fid,
        orElse: () => throw Exception('unknown family $fid'),
      );
}
