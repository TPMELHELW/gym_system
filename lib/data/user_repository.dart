// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/errors/firestore_errors.dart';
import 'package:gym_qr_code/features/auth/model/user_model.dart';
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

  Future<UserModel> fetchSpesificUser(String userId) async {
    try {
      final user = await _db.collection('users').doc(userId).get();
      return UserModel.fromMap(user.data()!);
    } on FirebaseException catch (e) {
      final errorMessage = handleFirestoreError(e);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Fetch all subscribers
  Future<List<SupescriberModel>> getUsers(String gymName) async {
    try {
      final snapshot = await _db
          .collection("subscribers")
          .where('gymName', isEqualTo: gymName)
          .get();
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
