import 'package:mvvm_patter_flutter/src/features/authentication/data/models/auth_data.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<AuthData?> loadSession() {
    throw UnimplementedError();
  }

  @override
  Future<AuthData> login() {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
