import 'package:mvvm_patter_flutter/src/features/profile/application/profile_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mvvm_patter_flutter/src/features/profile/data/model/user_profile.dart';
part 'profile_screen_controller.g.dart';

@Riverpod()
class ProfileScreenController extends _$ProfileScreenController {
  late final _service = ref.read(profileServiceProvider);
  @override
  ProfileScreenControllerState get state =>
      stateOrNull ?? ProfileScreenControllerState.empty();
  @override
  ProfileScreenControllerState build() {
    print("Init ProfileScreenController");
    _initialize();
    _disposing();
    return state;
  }

  Future<void> _loadProfileData() async {
    state = state.copyWith(userProfile: AsyncLoading());
    state = state.copyWith(
      userProfile: await AsyncValue.guard(
        () async => await _service.getProfile(),
      ),
    );
  }

  Future<void> _initialize() async {
    await _loadProfileData();
  }

  Future<void> reloadProfileData() async {
    await _loadProfileData();
  }

  void _disposing() {}
}

class ProfileScreenControllerState {
  final AsyncValue<UserProfile> userProfile;

  const ProfileScreenControllerState({
    required this.userProfile,
  });

  const ProfileScreenControllerState.empty({
    this.userProfile = const AsyncLoading(),
  });

  ProfileScreenControllerState copyWith({
    AsyncValue<UserProfile>? userProfile,
  }) {
    return ProfileScreenControllerState(
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
