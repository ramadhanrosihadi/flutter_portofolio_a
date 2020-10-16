import 'dart:convert';

class UserAccess {
  final String token_type;
  final int expires_in;
  final String access_token;
  final String refresh_token;
  UserAccess({
    this.token_type,
    this.expires_in,
    this.access_token,
    this.refresh_token,
  });

  UserAccess copyWith({
    String token_type,
    int expires_in,
    String access_token,
    String refresh_token,
  }) {
    return UserAccess(
      token_type: token_type ?? this.token_type,
      expires_in: expires_in ?? this.expires_in,
      access_token: access_token ?? this.access_token,
      refresh_token: refresh_token ?? this.refresh_token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token_type': token_type,
      'expires_in': expires_in,
      'access_token': access_token,
      'refresh_token': refresh_token,
    };
  }

  static UserAccess fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserAccess(
      token_type: map['token_type'],
      expires_in: map['expires_in']?.toInt(),
      access_token: map['access_token'],
      refresh_token: map['refresh_token'],
    );
  }

  String toJson() => json.encode(toMap());

  static UserAccess fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserAccess(token_type: $token_type, expires_in: $expires_in, access_token: $access_token, refresh_token: $refresh_token)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserAccess && o.token_type == token_type && o.expires_in == expires_in && o.access_token == access_token && o.refresh_token == refresh_token;
  }

  @override
  int get hashCode {
    return token_type.hashCode ^ expires_in.hashCode ^ access_token.hashCode ^ refresh_token.hashCode;
  }
}
