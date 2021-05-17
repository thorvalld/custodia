/*class User {
  final String fullname;
  final String email;
  final String phoneNumber;
  final String password;
  final String avatarURL;
  final int birthDate;
  final int credits;
  final UserRole userRole;
  final String macAddress;
  final String parentEmail;

  User(
      {this.fullname,
      this.email,
      this.phoneNumber,
      this.password,
      this.avatarURL,
      this.birthDate,
      this.credits,
      this.userRole,
      this.macAddress,
      this.parentEmail});
}*/

import 'package:custodia_parents/models/device_data.dart';

class User {
  User(
      {this.id,
      this.fullname,
      this.parentEmail,
      this.email,
      this.password,
      this.phoneNumber,
      this.macAddress,
      this.role,
      this.birthDate,
      this.avatarUrl,
      this.credits,
      this.deviceData});

  final String id;
  final String fullname;
  final String parentEmail;
  final String email;
  final String password;
  final String phoneNumber;
  final String macAddress;
  final String role;
  final String birthDate;
  final String avatarUrl;
  final int credits;
  final DeviceData deviceData;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullname: json["fullname"],
        parentEmail: json["parentEmail"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        macAddress: json["macAddress"],
        role: json["role"],
        birthDate: json["birthDate"],
        avatarUrl: json["avatarURL"],
        credits: json["credits"],
        deviceData: DeviceData.fromJson(json["deviceData"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "parentEmail": parentEmail,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "macAddress": macAddress,
        "role": role,
        "birthDate": birthDate,
        "avatarURL": avatarUrl,
        "credits": credits,
        "deviceData": deviceData.toJson(),
      };
}

enum UserRole { PARENT, CHILD }
