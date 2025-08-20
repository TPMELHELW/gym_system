import 'package:firebase_auth/firebase_auth.dart';

String handleAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case "invalid-email":
      return "The email address is badly formatted.";
    case "user-disabled":
      return "This user has been disabled.";
    case "user-not-found":
      return "No account found with this email.";
    case "wrong-password":
      return "Incorrect password.";
    case "email-already-in-use":
      return "This email is already in use.";
    case "weak-password":
      return "The password is too weak.";
    case "too-many-requests":
      return "Too many attempts. Try again later.";
    default:
      return "An unexpected error occurred: ${e.message}";
  }
}
