import 'package:get/get.dart';
import 'package:gym_qr_code/core/services/user_services.dart';
// import 'package:gym_qr_code/data/auth_repository.dart';
import 'package:gym_qr_code/data/user_repository.dart';

Future<void> initServices() async {
  // Get.put<AuthRepository>(AuthRepository());
  Get.putAsync<UserRepository>(() async => UserRepository());
  await Get.putAsync<UserServices>(
    () => UserServices().init(),
    permanent: true,
  );

  // authRepository.screenRedirect();
}
