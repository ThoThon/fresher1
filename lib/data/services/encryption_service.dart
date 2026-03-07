import 'dart:convert';
import 'package:cryptography/cryptography.dart';

class EncryptionService {
  static const int iterations = 100000;

  Future<String> hashWithPBKDF2(String password, String salt) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: 256,
    );

    final secretKey = await pbkdf2.deriveKeyFromPassword(
      password: password,
      nonce: utf8.encode(salt),
    );

    final bytes = await secretKey.extractBytes();
    return base64.encode(bytes);
  }
}
