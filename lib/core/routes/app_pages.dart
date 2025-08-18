import 'package:get/get.dart';
import 'package:gym_qr_code/core/routes/app_routes.dart';
import 'package:gym_qr_code/features/home_screen/screens/home_screen.dart';
import 'package:gym_qr_code/features/info/screens/info_screen.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/qr_codes_data_screen.dart';
import 'package:gym_qr_code/features/scan_qr_code/screens/scan_qr_code_screen.dart';

class AppPages {
  List<GetPage> get pages => [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.cupertino,
      // binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.info,
      page: () => const InfoScreen(),
      transition: Transition.cupertino,

      // binding: InfoBinding(),
    ),
    GetPage(
      name: AppRoutes.scan,
      page: () => const ScanQrCodeScreen(),
      transition: Transition.cupertino,

      // binding: ScanBinding(),
    ),
    GetPage(
      name: AppRoutes.qrData,
      page: () => const QrCodesDataScreen(),
      transition: Transition.cupertino,

      // binding: QrDataBinding(),
    ),
  ];
}
