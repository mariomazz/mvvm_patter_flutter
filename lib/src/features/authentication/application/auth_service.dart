import 'package:asf_flutter_common/asf_flutter_common.dart';
import 'package:mvvm_patter_flutter/src/features/authentication/data/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository_interface.dart';
import '../data/models/auth_data.dart';
part 'auth_service.g.dart';

class AuthService {
  final IAuthRepository _repo;
  AuthService(this._repo);

  final _authState = InMemoryStore<AuthData?>(null);

  Future<void> login() async {
    final authData = await _repo.login();
    _authState.value = authData;
  }

  Future<void> logout() async {
    await _repo.logout();
    _authState.value = null;
  }

  Future<void> loadSession() async {
    final authData = await _repo.loadSession();
    _authState.value = authData;
  }

  Stream<bool> onChangeIsAuth() {
    return _authState.stream.map((event) => event != null);
  }

  bool get isAuth => _authState.value != null;
}

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthService(repo);
}
