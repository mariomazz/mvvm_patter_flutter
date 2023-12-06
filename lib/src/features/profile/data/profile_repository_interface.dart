import 'model/user_profile.dart';

abstract class IProfileRepository {
  Future<UserProfile> getProfile();
}
