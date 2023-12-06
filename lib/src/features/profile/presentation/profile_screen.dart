import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_screen_controller.dart';
import 'reload_profile_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(context, ref) {
    final _viewModel = ref.read(profileScreenControllerProvider.notifier);
    final viewModelState = ref.watch(profileScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          ReloadProfileButton(parentViewModel: _viewModel),
        ],
      ),
      body: viewModelState.userProfile.when(
        data: (user) {
          return SizedBox.expand(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 10),
                  Text("CIAO PROFILO"),
                  SizedBox(height: 10),
                  Text(user.name),
                  SizedBox(height: 10),
                  Text(user.surname),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
        error: (e, s) {
          return Center(child: Text(e.toString()));
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
      /* body: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 10),
              Text("CIAO PROFILO"),
              SizedBox(height: 10),
              Text(viewModelState.userName),
              SizedBox(height: 10),
              Text(viewModelState.userSurname),
              SizedBox(height: 10),
            ],
          ),
        ),
      ), */
    );
  }
}
