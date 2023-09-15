import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'MOCKAPI_URL', obfuscate: true)
  static final String mockapiUrl = _Env.mockapiUrl; 
}
