import 'package:hive/hive.dart';

part 'account_model.g.dart';

@HiveType(typeId: 0)
class AccountModel {
  @HiveField(0)
  final String taxIdOrId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String passwordHash;

  @HiveField(3)
  final String salt;

  @HiveField(4)
  final String fullName;

  @HiveField(5)
  final bool enabled;

  @HiveField(6)
  final int updatedAt;

  AccountModel({
    required this.taxIdOrId,
    required this.username,
    required this.passwordHash,
    required this.salt,
    required this.fullName,
    required this.enabled,
    required this.updatedAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        taxIdOrId: json['taxIdOrId'] ?? '',
        username: json['username'] ?? '',
        passwordHash: json['passwordHash'] ?? '',
        salt: json['salt'] ?? '',
        fullName: json['fullName'] ?? '',
        enabled: json['enabled'] ?? true,
        updatedAt: json['updatedAt'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'taxIdOrId': taxIdOrId,
        'username': username,
        'passwordHash': passwordHash,
        'salt': salt,
        'fullName': fullName,
        'enabled': enabled,
        'updatedAt': updatedAt,
      };
}
