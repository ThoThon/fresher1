import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/account_model.dart';
import '../services/storage_service.dart';
import '../services/encryption_service.dart';

class AuthRepository {
  final StorageService _storage = Get.find<StorageService>();
  final EncryptionService _encryption = Get.find<EncryptionService>();

  Future<AccountModel?> login(
      String taxId, String username, String password) async {
    final localAcc = _storage.getAccount(username);

    if (localAcc == null || !localAcc.enabled) return null;

    if (localAcc.taxIdOrId != taxId) return null;

    final inputHash = await _encryption.hashWithPBKDF2(password, localAcc.salt);

    if (inputHash == localAcc.passwordHash) {
      await _storage.saveSession(username);
      return localAcc;
    }

    return null;
  }

  Future<void> syncFromFirebase() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('accounts')
          .where('enabled', isEqualTo: true)
          .get();

      final List<AccountModel> accounts = snapshot.docs
          .map((doc) => AccountModel.fromJson(doc.data()))
          .toList();

      await _storage.saveAccounts(accounts);
    } catch (e) {
      debugPrint("Lỗi đồng bộ: $e");
    }
  }
}
