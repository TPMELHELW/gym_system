import 'package:get/get.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/supescriber_model.dart';

class EarlyEndController extends GetxController {
  static EarlyEndController get to => Get.find();

  final QrCodesDataController qrCodesDataController = QrCodesDataController.to;
  final RxList<SupescriberModel> expiringUsers = <SupescriberModel>[].obs;

  void checkExpiringSubscriptions() {
    final now = DateTime.now();

    expiringUsers.value = qrCodesDataController.users.where((user) {
      final diff = user.endDateAsDateTime.difference(now).inDays;
      return diff <= 5 && diff >= 0;
    }).toList();
  }

  @override
  void onInit() {
    checkExpiringSubscriptions();
    super.onInit();
  }
}
