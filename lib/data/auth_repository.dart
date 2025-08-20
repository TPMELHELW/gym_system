import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/errors/auth_errors.dart';
import 'package:gym_qr_code/core/routes/app_routes.dart';
import 'package:gym_qr_code/features/auth/login_screen/screens/login_screen.dart';

class AuthRepository extends GetxService {
  final _auth = FirebaseAuth.instance;

  final currentUser = FirebaseAuth.instance.currentUser;

  void screenRedirect() {
    if (_auth.currentUser != null) {
      // if (_auth.currentUser?.emailVerified ?? false) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      // storage.writeIfNull("isFirstTime", true);
      // storage.read("isFirstTime")
      //     ? Get.offAll(() => const OnBoardingScreen())
      Get.offAll(() => const LoginScreen());
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

  // Future<void>
}
