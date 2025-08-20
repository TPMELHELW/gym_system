import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String id; // Can be Firebase docId or local unique id

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String startDate; // stored as String for Hive simplicity

  @HiveField(3)
  final String endDate;

  @HiveField(4)
  final String imagePath;

  UserModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.imagePath,
  });

  /// 🔹 Helper to parse endDate as DateTime
  DateTime get endDateAsDateTime => DateTime.parse(endDate);

  /// 🔹 Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'startDate': startDate,
      'endDate': endDate,
      'imagePath': imagePath,
    };
  }

  /// 🔹 Create from Map (Firebase)
  factory UserModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return UserModel(
      id: map['id'] ?? docId ?? '',
      name: map['name'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }

  /// 🔹 Create from Firestore DocumentSnapshot
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel.fromMap(data, docId: snapshot.id);
  }
}
