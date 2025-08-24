import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/errors/auth_errors.dart';
import 'package:gym_qr_code/core/routes/app_routes.dart';

class AuthRepository extends GetxController {
  final _auth = FirebaseAuth.instance;

  final currentUser = FirebaseAuth.instance.currentUser;

  void screenRedirect() {
    if (_auth.currentUser != null) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final errorMessage = handleAuthError(e);
      throw Exception(errorMessage);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Failed to sign out: ${e.toString()}");
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      final errorMessage = handleAuthError(e);
      throw Exception(errorMessage);
    }
  }

  @override
  void onReady() {
    screenRedirect();
    super.onReady();
  }
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // Future<void>
}
