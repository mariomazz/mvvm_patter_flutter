import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_screen_controller.dart';
import 'reload_profile_button_controller.dart';

class ReloadProfileButton extends ConsumerStatefulWidget {
  final ProfileScreenController parentViewModel;
  const ReloadProfileButton({
    required this.parentViewModel,
  });

  @override
  ConsumerState<ReloadProfileButton> createState() =>
      _ReloadProfileButtonState();
}

class _ReloadProfileButtonState extends ConsumerState<ReloadProfileButton> {
  late final _provider =
      reloadProfileButtonControllerProvider(widget.parentViewModel);
  late final _viewModel = ref.read(_provider.notifier);

  @override
  Widget build(context) {
    // final viewModelState = ref.watch(_provider);
    return Row(
      children: [
        _viewModel.asyncUserProfile.when(
          data: (user) {
            return Column(
              children: [
                SizedBox(height: 5),
                Text(user.name),
                SizedBox(height: 5),
                Text(user.surname),
                SizedBox(height: 5),
              ],
            );
          },
          loading: () {
            return CircularProgressIndicator();
          },
          error: (Object error, StackTrace stackTrace) {
            return SizedBox.shrink();
          },
        ),
        IconButton(
          onPressed: () {
            _viewModel.updateProfileData();
          },
          icon: Icon(Icons.refresh_rounded),
        ),
      ],
    );
  }
}
