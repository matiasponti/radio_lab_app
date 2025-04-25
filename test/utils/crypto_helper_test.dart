import 'package:flutter_test/flutter_test.dart';
import 'package:radio_lab_app/utils/crypto_helper.dart';
import 'package:radio_lab_app/utils/secure_constants.dart';

void main() {
  const originalUrl =
      'https://de1.api.radio-browser.info/json/stations?hidebroken=true&codec=MP3&order=clickcount&reverse=true';

  test('Decryption of encrypted radio URL should return the original URL', () {
    final decrypted = SecureConstants.radioBrowserUrl;
    expect(decrypted, originalUrl);
  });

  test('Encrypting then decrypting a URL should return the original', () {
    final encrypted = CryptoHelper.encryptText(originalUrl);
    final decrypted = CryptoHelper.decryptText(encrypted);
    expect(decrypted, originalUrl);
  });
}
