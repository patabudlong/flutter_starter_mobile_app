class User {
  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String middleName;
  final String extensionName;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.extensionName,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName {
    final nameParts = [
      firstName,
      middleName,
      lastName,
      if (extensionName.isNotEmpty) extensionName,
    ];
    return nameParts.where((part) => part.isNotEmpty).join(' ');
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      extensionName: json['extension_name'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'extension_name': extensionName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
} 