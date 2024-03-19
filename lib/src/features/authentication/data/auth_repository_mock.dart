import 'package:faker/faker.dart';
import 'package:mvvm_patter_flutter/src/features/authentication/data/models/auth_data.dart';
import 'auth_repository_interface.dart';

class AuthRepositoryMock implements IAuthRepository {
  @override
  Future<AuthData?> loadSession() async {
    return AuthData(accessToken: faker.jwt.custom(expiresIn: DateTime.now().add(Duration(days: 1)), payload: {}));
  }

  @override
  Future<AuthData> login() async {
    return AuthData(accessToken: faker.jwt.custom(expiresIn: DateTime.now().add(Duration(days: 1)), payload: {}));
  }

  @override
  Future<void> logout() async {}
}
