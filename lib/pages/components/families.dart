import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../../entities/family.dart';
import '../../repositories/family_repository.dart';

final familiesProvider = FutureProvider(
  (ref) async {
    final familyRepository = ref.watch(familyRepositoryProvider);
    return familyRepository.getFamilies();
  },
);

final familyProvider = FutureProvider.family<Family, String>(
  (ref, fid) async {
    final familyRepository = ref.watch(familyRepositoryProvider);
    return familyRepository.getFamily(fid);
  },
);
