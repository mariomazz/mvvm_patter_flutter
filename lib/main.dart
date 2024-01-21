import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_patter_flutter/src/features/authentication/application/auth_service.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authServiceProvider).loadSession();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}
