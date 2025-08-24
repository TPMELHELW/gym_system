import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  /// 🔹 Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  /// 🔹 Create from Map (Firebase)
  factory UserModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return UserModel(
      id: map['id'] ?? docId ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
