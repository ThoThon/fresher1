import 'package:hive_flutter/hive_flutter.dart';
import '../models/account_model.dart';

class StorageService {
  static const String accountsBoxName = 'accounts';
  static const String authBoxName = 'auth_session';

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AccountModelAdapter());
    }

    await Hive.openBox<AccountModel>(accountsBoxName);
    await Hive.openBox(authBoxName);
  }

  Future<void> saveAccounts(List<AccountModel> accounts) async {
    var box = Hive.box<AccountModel>(accountsBoxName);
    for (var acc in accounts) {
      await box.put(acc.username, acc);
    }
  }

  AccountModel? getAccount(String username) {
    var box = Hive.box<AccountModel>(accountsBoxName);
    return box.get(username);
  }

  Future<void> saveSession(String username) async {
    var box = Hive.box(authBoxName);
    await box.put('current_user', username);
    await box.put('login_at', DateTime.now().millisecondsSinceEpoch);
  }

  String? getSession() {
    var box = Hive.box(authBoxName);
    return box.get('current_user');
  }

  Future<void> clearSession() async {
    var box = Hive.box(authBoxName);
    await box.clear();
  }
}
