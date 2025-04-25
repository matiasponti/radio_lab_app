import 'package:radio_lab_app/utils/crypto_helper.dart';

class SecureConstants {
  static const String _encryptedRadioBrowserUrl =
      'lNkFK6QBc58s6rUhWt0Rp3vDa0oE9mEfyBy9457/SVEfDwO8K8tDPVRWxb/gqbGXI+mm8REAAWVvCteG7gO0gS4Ld5jUjH0kMCsZ1QLUS+XuXZxx+zZXxIuCraNfmqLJixkG5l5aV1ADh4A+6xWW3Q==';

  static String get radioBrowserUrl =>
      CryptoHelper.decryptText(_encryptedRadioBrowserUrl);
}
