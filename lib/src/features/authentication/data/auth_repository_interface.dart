import 'models/auth_data.dart';

abstract class IAuthRepository {
  Future<AuthData> login();

  Future<void> logout();

  Future<AuthData?> loadSession();
}
