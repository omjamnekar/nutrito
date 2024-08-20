import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:moke_app/model/user.dart';
import 'package:riverpod/riverpod.dart'; // For JSON encoding/decoding

// Define a StateNotifier to manage UserManager state
class UserDataNotifier extends StateNotifier<UserManager?> {
  final _storage = const FlutterSecureStorage();

  UserDataNotifier() : super(null) {
    loadUserData();
  }

  Future<void> loadUserData() async {
    final userDataJson = await _storage.read(key: 'user_data');
    if (userDataJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userDataJson);
      state = UserManager.fromMap(userMap);
    }
  }

  void saveUserData(UserManager user) async {
    final String userDataJson = jsonEncode(user.toMap());
    await _storage.write(key: 'user_data', value: userDataJson);
    state = user;
  }

  Future<void> clearUserData() async {
    await _storage.delete(key: 'user_data');
    state = null;
  }
}

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, UserManager?>((ref) {
  return UserDataNotifier();
});
