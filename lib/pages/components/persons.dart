import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../../entities/person.dart';
import '../../repositories/family_repository.dart';

final personProvider = FutureProvider.family<FamilyPerson, PersonParameter>(
  (ref, parameter) async {
    final familyRepository = ref.watch(familyRepositoryProvider);
    return familyRepository.getPerson(parameter.fid, parameter.pid);
  },
);

class PersonParameter {
  const PersonParameter({
    required this.fid,
    required this.pid,
  });

  final String fid;
  final int pid;
}
