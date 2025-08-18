import 'package:get/get.dart';

class InfoController extends GetxController {
  bool isFade = false;

  @override
  void onInit() {
    Future.delayed(Duration(milliseconds: 400), () {
      isFade = true;
      update();
    });
    super.onInit();
  }
}
