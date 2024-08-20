import 'package:uuid/uuid.dart';

class UserManager {
  String id;
  String name;
  String phone;
  String email;

  // Constructor

  UserManager({
    String? id, // Optional parameter for id
    required this.name,
    required this.phone,
    required this.email,
  }) : id = id ?? Uuid().v4();

  // Convert an instance of UserManager to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  // Create an instance of UserManager from a Map
  factory UserManager.fromMap(Map<String, dynamic> map) {
    return UserManager(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
