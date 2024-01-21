import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_patter_flutter/src/features/authentication/application/auth_service.dart';

class NoAuthScreen extends ConsumerWidget {
  const NoAuthScreen({super.key});

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("no auth"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              onPressed: () async {
                await ref.read(authServiceProvider).login();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("auth action"),
                  SizedBox(width: 12.5),
                  Icon(Icons.login),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
