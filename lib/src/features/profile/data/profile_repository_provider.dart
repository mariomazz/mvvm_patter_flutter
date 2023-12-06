import 'package:mvvm_patter_flutter/src/features/profile/data/profile_repository_interface.dart';
import 'package:mvvm_patter_flutter/src/features/profile/data/profile_repository_mock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_repository_provider.g.dart';

@Riverpod()
IProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryMock();
}
