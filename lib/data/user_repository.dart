// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/errors/firestore_errors.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/supescriber_model.dart';

class UserRepository extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Add or update user
  Future<void> saveUser(SupescriberModel user) async {
    try {
      await _db.collection("subscribers").doc(user.id).set(user.toMap());
    } on FirebaseException catch (e) {
      final errorMessage = handleFirestoreError(e);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Fetch all subscribers
  Future<List<SupescriberModel>> getUsers() async {
    try {
      final snapshot = await _db.collection("subscribers").get();
      return snapshot.docs
          .map((doc) => SupescriberModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      final errorMessage = handleFirestoreError(e);
      throw Exception(errorMessage);
      // return [];
    }
  }

  /// Delete user
  Future<void> deleteUser(String id) async {
    try {
      await _db.collection("subscribers").doc(id).delete();
    } on FirebaseException catch (e) {
      final errorMessage = handleFirestoreError(e);
      throw Exception(errorMessage);
    }
  }
}
