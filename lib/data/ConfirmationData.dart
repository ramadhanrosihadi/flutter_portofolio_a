import 'dart:convert';

class ConfirmationData {
  final String code;
  final int user_id;
  final String expired_at;
  final int confirmation_type_id;
  final String updated_at;
  final String created_at;
  final int id;
  final int bypass;
  ConfirmationData({
    this.code,
    this.user_id,
    this.expired_at,
    this.confirmation_type_id,
    this.updated_at,
    this.created_at,
    this.id,
    this.bypass,
  });

  ConfirmationData copyWith({
    String code,
    int user_id,
    String expired_at,
    int confirmation_type_id,
    String updated_at,
    String created_at,
    int id,
    int bypass,
  }) {
    return ConfirmationData(
      code: code ?? this.code,
      user_id: user_id ?? this.user_id,
      expired_at: expired_at ?? this.expired_at,
      confirmation_type_id: confirmation_type_id ?? this.confirmation_type_id,
      updated_at: updated_at ?? this.updated_at,
      created_at: created_at ?? this.created_at,
      id: id ?? this.id,
      bypass: bypass ?? this.bypass,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'user_id': user_id,
      'expired_at': expired_at,
      'confirmation_type_id': confirmation_type_id,
      'updated_at': updated_at,
      'created_at': created_at,
      'id': id,
      'bypass': bypass,
    };
  }

  factory ConfirmationData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ConfirmationData(
      code: map['code'],
      user_id: map['user_id']?.toInt(),
      expired_at: map['expired_at'],
      confirmation_type_id: map['confirmation_type_id']?.toInt(),
      updated_at: map['updated_at'],
      created_at: map['created_at'],
      id: map['id']?.toInt(),
      bypass: map['bypass']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfirmationData.fromJson(String source) => ConfirmationData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConfirmationData(code: $code, user_id: $user_id, expired_at: $expired_at, confirmation_type_id: $confirmation_type_id, updated_at: $updated_at, created_at: $created_at, id: $id, bypass: $bypass)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConfirmationData &&
        o.code == code &&
        o.user_id == user_id &&
        o.expired_at == expired_at &&
        o.confirmation_type_id == confirmation_type_id &&
        o.updated_at == updated_at &&
        o.created_at == created_at &&
        o.id == id &&
        o.bypass == bypass;
  }

  @override
  int get hashCode {
    return code.hashCode ^ user_id.hashCode ^ expired_at.hashCode ^ confirmation_type_id.hashCode ^ updated_at.hashCode ^ created_at.hashCode ^ id.hashCode ^ bypass.hashCode;
  }
}
