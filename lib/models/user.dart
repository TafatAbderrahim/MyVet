import 'dart:convert';

import 'package:hive/hive.dart';

class User {
  String cookie = '';
  String id = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String profilePic = '';
  bool isSeller = false;
  bool isConnected = false;
  User({
    required this.cookie,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePic,
    required this.isSeller,
    required this.isConnected,
  });

  @override
  List<Object> get props {
    return [
      cookie,
      id,
      firstName,
      lastName,
      email,
      profilePic,
      isSeller,
      isConnected,
    ];
  }

  void toHive() {
    final _box = Hive.box('user');
    _box.put('cookie', this.cookie);
    _box.put('id', this.id);
    _box.put('firstName', this.firstName);
    _box.put('lastName', this.lastName);
    _box.put('email', this.email);
    _box.put('profilePic', this.profilePic);
    _box.put('isSeller', this.isSeller);
    _box.put('isConnected', this.isConnected);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'cookie': cookie});
    result.addAll({'id': id});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'profilePic': profilePic});
    result.addAll({'isSeller': isSeller});
    result.addAll({'isConnected': isConnected});

    return result;
  }

  fromMap(Map<String, dynamic> map, String? cookie) {
    this.cookie = cookie!;
    this.id = map['id'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.email = map['email'];
    this.profilePic = map['pic'];
    this.isSeller = map['isSeller'];
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePic,
    bool? isSeller,
    bool? isConnected,
  }) {
    return User(
      cookie: cookie ?? this.cookie,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      isSeller: isSeller ?? this.isSeller,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  // factory User.fromMap(Map<String, dynamic> map) {
  //   return User(
  //     id: map['id']?.toInt() ?? 0,
  //     firstName: map['firstName'] ?? '',
  //     lastName: map['lastName'] ?? '',
  //     email: map['email'] ?? '',
  //     profilePic: map['profilePic'] ?? '',
  //     isSeller: map['isSeller'] ?? false,
  //     isConnected: map['isConnected'] ?? false,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory User.fromJson(String source) => User.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, profilePic: $profilePic, isSeller: $isSeller, isConnected: $isConnected)';
  // }
}
