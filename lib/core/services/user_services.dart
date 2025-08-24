import 'package:get/get.dart';
import 'package:gym_qr_code/features/auth/model/user_model.dart';
import 'package:hive/hive.dart';

class UserServices extends GetxService {
  static const String boxName = "userBox";
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  Future<UserServices> init() async {
    // _prefs = Get.find<SharedPreferencesService>();
    await getUsers();
    return this;
  }

  Future<Box<UserModel>> get _box async =>
      await Hive.openBox<UserModel>(boxName);

  Future<void> addUser(UserModel user) async {
    final box = await _box;
    await box.add(user);
  }

  Future<UserModel> getUsers() async {
    final box = await _box;
    currentUser.value = box.values.first;
    return box.values.first;
  }

  Future<void> deleteUserAt(int index) async {
    final box = await _box;
    await box.deleteAt(index);
  }

  Future<void> updateUserAt(int index, UserModel updatedUser) async {
    final box = await _box;
    await box.putAt(index, updatedUser);
  }

  Future<UserModel?> getUserById(String id) async {
    final box = await _box;
    return box.values.firstWhere((user) => user.id == id);
  }
}
