import 'package:get/get.dart';
import 'package:gym_qr_code/data/auth_repository.dart';
import 'package:gym_qr_code/data/user_repository.dart';

Future<void> initServices() async {
  Get.putAsync<AuthRepository>(() async => AuthRepository());
  Get.putAsync<UserRepository>(() async => UserRepository());
}
