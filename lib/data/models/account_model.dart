class AccountModel {
  final String taxIdOrId;
  final String username;
  final String passwordHash;
  final String salt;
  final String fullName;
  final bool enabled;
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
