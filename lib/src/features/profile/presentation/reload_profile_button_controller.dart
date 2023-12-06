import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/model/user_profile.dart';
import 'profile_screen_controller.dart';
part 'reload_profile_button_controller.g.dart';

@Riverpod()
class ReloadProfileButtonController extends _$ReloadProfileButtonController {
  @override
  ReloadProfileButtonControllerState get state =>
      stateOrNull ?? ReloadProfileButtonControllerState.empty();
  @override
  ReloadProfileButtonControllerState build(
      ProfileScreenController parentViewModel) {
    print("Init ReloadProfileButtonController");
    return state;
  }

  void updateProfileData() {
    parentViewModel.reloadProfileData();
  }

  AsyncValue<UserProfile> get asyncUserProfile => parentViewModel.state.userProfile;


}

class ReloadProfileButtonControllerState {
  const ReloadProfileButtonControllerState();

  const ReloadProfileButtonControllerState.empty();

  ReloadProfileButtonControllerState copyWith() {
    return ReloadProfileButtonControllerState();
  }
}
