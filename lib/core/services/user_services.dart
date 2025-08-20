import 'package:gym_qr_code/features/qr_codes_data_screen/model/supescriber_model.dart';
import 'package:hive/hive.dart';

class UserServices {
  static const String boxName = "usersBox";

  Future<Box<SupescriberModel>> get _box async =>
      await Hive.openBox<SupescriberModel>(boxName);

  Future<void> addUser(SupescriberModel user) async {
    final box = await _box;
    await box.add(user);
  }

  Future<List<SupescriberModel>> getUsers() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<void> deleteUserAt(int index) async {
    final box = await _box;
    await box.deleteAt(index);
  }

  Future<void> updateUserAt(int index, SupescriberModel updatedUser) async {
    final box = await _box;
    await box.putAt(index, updatedUser);
  }

  Future<SupescriberModel?> getUserById(int id) async {
    final box = await _box;
    return box.values.firstWhere((user) => user.id == id);
  }
}
