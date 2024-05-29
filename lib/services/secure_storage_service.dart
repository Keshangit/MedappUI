import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Method to store a JWT token securely
  Future<void> storeToken(String token) async {
    await _storage.write(key: 'token', value: token);
    // print(token);
  }

  // Method to retrieve the stored JWT token
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // Method to delete the stored JWT token
  Future<void> deleteToken() async {
    await _storage.delete(key: 'access_token');
  }

  // Method to store a user Id securely
  Future<void> storeUserId(String userId) async {
    await _storage.write(key: 'user_id', value: userId);
  }

  // Method to retrieve the stored user Id
  Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }

  // Method to delete the stored user Id
  Future<void> deleteUserId() async {
    await _storage.delete(key: 'user_id');
  }

  // Method to store a user role
  Future<void> storeRole(String role) async {
    await _storage.write(key: 'role', value: role);
  }

  // Method to retrieve the stored role
  Future<String?> getRole() async {
    return await _storage.read(key: 'role');
  }

  // Method to delete the stored data
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
