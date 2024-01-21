import 'package:mvvm_patter_flutter/src/features/authentication/data/auth_repository_interface.dart';
import 'package:mvvm_patter_flutter/src/features/authentication/data/auth_repository_mock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
IAuthRepository authRepository(AuthRepositoryRef ref){
  return AuthRepositoryMock();
}