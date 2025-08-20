import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  /// 🔹 Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }

  /// 🔹 Create from Map (Firebase)
  factory UserModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return UserModel(
      id: map['id'] ?? docId ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
