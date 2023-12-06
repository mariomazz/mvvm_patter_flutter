import 'package:mvvm_patter_flutter/src/features/profile/data/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/model/user_profile.dart';
import '../data/profile_repository_interface.dart';
part 'profile_service.g.dart';

class ProfileService {
  final IProfileRepository repository;
  ProfileService({
    required this.repository,
  });

  Future<UserProfile> getProfile() async {
    return repository.getProfile();
  }
}

@Riverpod()
ProfileService profileService(ProfileServiceRef ref) {
  final repository = ref.read(profileRepositoryProvider);
  return ProfileService(repository: repository);
}
