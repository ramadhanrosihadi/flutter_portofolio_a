import 'dart:convert';

import 'Berkas.dart';
import 'UserAccess.dart';

class User {
  final int id;
  final String number_id;
  final String name;
  final String email;
  final String phone;
  final String email_verified_at;
  final String phone_verified_at;
  String token_firebase;
  final int is_active;
  final int built_in;
  String last_signedin;
  final String last_access;
  final String last_update_location;
  final int latitude;
  final int longitude;
  final String device_info;
  final String current_apk_version_name;
  final String current_apk_version_code;
  final String created_at;
  final String updated_at;
  UserAccess access;
  Berkas file;
  String roles;
  String jenis_kelamin;
  String pin;
  User({
    this.id,
    this.number_id,
    this.name,
    this.email,
    this.phone,
    this.email_verified_at,
    this.phone_verified_at,
    this.token_firebase,
    this.is_active,
    this.built_in,
    this.last_signedin,
    this.last_access,
    this.last_update_location,
    this.latitude,
    this.longitude,
    this.device_info,
    this.current_apk_version_name,
    this.current_apk_version_code,
    this.created_at,
    this.updated_at,
    this.access,
    this.file,
    this.roles,
    this.jenis_kelamin,
    this.pin,
  });

  User copyWith(
      {int id,
      String number_id,
      String name,
      String email,
      String phone,
      String email_verified_at,
      String phone_verified_at,
      String token_firebase,
      int is_active,
      int built_in,
      String last_signedin,
      String last_access,
      String last_update_location,
      int latitude,
      int longitude,
      String device_info,
      String current_apk_version_name,
      String current_apk_version_code,
      String created_at,
      String updated_at,
      UserAccess access,
      Berkas file,
      String roles}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      email_verified_at: email_verified_at ?? this.email_verified_at,
      phone_verified_at: phone_verified_at ?? this.phone_verified_at,
      token_firebase: token_firebase ?? this.token_firebase,
      is_active: is_active ?? this.is_active,
      built_in: built_in ?? this.built_in,
      last_signedin: last_signedin ?? this.last_signedin,
      last_access: last_access ?? this.last_access,
      last_update_location: last_update_location ?? this.last_update_location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      device_info: device_info ?? this.device_info,
      current_apk_version_name: current_apk_version_name ?? this.current_apk_version_name,
      current_apk_version_code: current_apk_version_code ?? this.current_apk_version_code,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      access: access ?? this.access,
      file: file ?? this.file,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number_id': number_id,
      'name': name,
      'email': email,
      'phone': phone,
      'email_verified_at': email_verified_at,
      'phone_verified_at': phone_verified_at,
      'token_firebase': token_firebase,
      'is_active': is_active,
      'built_in': built_in,
      'last_signedin': last_signedin,
      'last_access': last_access,
      'last_update_location': last_update_location,
      'latitude': latitude,
      'longitude': longitude,
      'device_info': device_info,
      'current_apk_version_name': current_apk_version_name,
      'current_apk_version_code': current_apk_version_code,
      'created_at': created_at,
      'updated_at': updated_at,
      'access': access?.toMap(),
      'file': file?.toMap(),
      'roles': roles,
      'jenis_kelamin': jenis_kelamin,
      'pin': pin,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return User(
      id: map['id']?.toInt(),
      number_id: map['number_id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      email_verified_at: map['email_verified_at'],
      phone_verified_at: map['phone_verified_at'],
      token_firebase: map['token_firebase'],
      is_active: map['is_active']?.toInt(),
      built_in: map['built_in']?.toInt(),
      last_signedin: map['last_signedin'],
      last_access: map['last_access'],
      last_update_location: map['last_update_location'],
      latitude: map['latitude']?.toInt(),
      longitude: map['longitude']?.toInt(),
      device_info: map['device_info'],
      current_apk_version_name: map['current_apk_version_name'],
      current_apk_version_code: map['current_apk_version_code'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      access: UserAccess.fromMap(map['access']),
      file: Berkas.fromMap(map['file']),
      roles: map['roles'],
      jenis_kelamin: map['jenis_kelamin'],
      pin: map['pin'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) {
    try {
      return fromMap(json.decode(source));
    } catch (e) {
      return User();
    }
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, email_verified_at: $email_verified_at, phone_verified_at: $phone_verified_at, token_firebase: $token_firebase, is_active: $is_active, built_in: $built_in, last_signedin: $last_signedin, last_access: $last_access, last_update_location: $last_update_location, latitude: $latitude, longitude: $longitude, device_info: $device_info, current_apk_version_name: $current_apk_version_name, current_apk_version_code: $current_apk_version_code, created_at: $created_at, updated_at: $updated_at, access: $access, file: $file)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.id == id &&
        o.name == name &&
        o.email == email &&
        o.phone == phone &&
        o.email_verified_at == email_verified_at &&
        o.phone_verified_at == phone_verified_at &&
        o.token_firebase == token_firebase &&
        o.is_active == is_active &&
        o.built_in == built_in &&
        o.last_signedin == last_signedin &&
        o.last_access == last_access &&
        o.last_update_location == last_update_location &&
        o.latitude == latitude &&
        o.longitude == longitude &&
        o.device_info == device_info &&
        o.current_apk_version_name == current_apk_version_name &&
        o.current_apk_version_code == current_apk_version_code &&
        o.created_at == created_at &&
        o.updated_at == updated_at &&
        o.access == access &&
        o.file == file &&
        o.roles == roles;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        email_verified_at.hashCode ^
        phone_verified_at.hashCode ^
        token_firebase.hashCode ^
        is_active.hashCode ^
        built_in.hashCode ^
        last_signedin.hashCode ^
        last_access.hashCode ^
        last_update_location.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        device_info.hashCode ^
        current_apk_version_name.hashCode ^
        current_apk_version_code.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        access.hashCode ^
        file.hashCode ^
        roles.hashCode;
  }

  String profilePath() {
    if (file != null) {
      return file.full_path_thumbnail;
    }
    return "";
  }

  String getRole() {
    if (roles != null) {
      if (roles.contains("customer")) {
        return "customer";
      } else if (roles.contains("admin")) {
        return "admin";
      } else if (roles.contains("kbih")) {
        return "kbih";
      }
    }
    return "";
  }

  String appVersion() {
    if (current_apk_version_name != null) {
      return current_apk_version_name + ' (' + current_apk_version_code + ') ';
    }
    return "-";
  }

  String getDeviceInfoAppVersion() {
    String result = "";
    if (current_apk_version_name != null) {
      result += current_apk_version_name + ' (' + current_apk_version_code + ') ';
    }
    if (device_info != null) {
      result += ' ' + device_info;
    }
    if (result.isEmpty) result = "-";
    return result;
  }

  static List<User> fromListDynamic(List<dynamic> datas) {
    if (datas == null) return [];
    return datas.map<User>((e) => User.fromMap(e)).toList();
  }
}
