import 'package:faker/faker.dart';
import 'package:mvvm_patter_flutter/src/features/profile/data/model/user_profile.dart';
import 'package:mvvm_patter_flutter/src/features/profile/data/profile_repository_interface.dart';

class ProfileRepositoryMock implements IProfileRepository {
  @override
  Future<UserProfile> getProfile() async {
    await Future.delayed(Duration(milliseconds: 1500));
    return UserProfile(
      name: faker.person.firstName(),
      surname: faker.person.lastName(),
    );
  }
}
