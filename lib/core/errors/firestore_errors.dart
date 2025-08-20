import 'package:firebase_core/firebase_core.dart';

String handleFirestoreError(FirebaseException e) {
  switch (e.code) {
    case "permission-denied":
      return "You don't have permission to perform this action.";
    case "unavailable":
      return "Firestore is currently unavailable. Try again later.";
    case "not-found":
      return "The requested document was not found.";
    case "already-exists":
      return "This document already exists.";
    case "cancelled":
      return "The request was cancelled.";
    case "deadline-exceeded":
      return "The operation took too long. Try again.";
    case "invalid-argument":
      return "Invalid data provided.";
    default:
      return "Unexpected error: ${e.message}";
  }
}
