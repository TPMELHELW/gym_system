import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String startDate;

  @HiveField(2)
  final String endDate;

  @HiveField(3)
  final String imagePath;

  @HiveField(4)
  final int id;

  UserModel({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.imagePath,
    required this.id,
  });
}
