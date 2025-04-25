import 'package:encrypt/encrypt.dart' as encrypt;

class CryptoHelper {
  static final _key = encrypt.Key.fromUtf8('1234567890123456');

  static final _iv = encrypt.IV.fromUtf8('abcdefghijklmnop');

  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  static String encryptText(String text) {
    final encrypted = _encrypter.encrypt(text, iv: _iv);
    return encrypted.base64;
  }

  static String decryptText(String base64Text) {
    return _encrypter.decrypt64(base64Text, iv: _iv);
  }
}
