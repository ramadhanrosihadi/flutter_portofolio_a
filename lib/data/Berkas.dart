import 'dart:convert';

class Berkas {
  final String folder;
  final String path;
  final String path_thumbnail;
  final int ftype_id;
  final int user_id;
  final String ext;
  final String full_path;
  final String full_path_thumbnail;
  final int size_in_bytes;
  final String updated_at;
  final String created_at;
  final int id;
  Berkas({
    this.folder,
    this.path,
    this.path_thumbnail,
    this.ftype_id,
    this.user_id,
    this.ext,
    this.full_path,
    this.full_path_thumbnail,
    this.size_in_bytes,
    this.updated_at,
    this.created_at,
    this.id,
  });

  Berkas copyWith({
    String folder,
    String path,
    String path_thumbnail,
    int ftype_id,
    int user_id,
    String ext,
    String full_path,
    String full_path_thumbnail,
    int size_in_bytes,
    String updated_at,
    String created_at,
    int id,
  }) {
    return Berkas(
      folder: folder ?? this.folder,
      path: path ?? this.path,
      path_thumbnail: path_thumbnail ?? this.path_thumbnail,
      ftype_id: ftype_id ?? this.ftype_id,
      user_id: user_id ?? this.user_id,
      ext: ext ?? this.ext,
      full_path: full_path ?? this.full_path,
      full_path_thumbnail: full_path_thumbnail ?? this.full_path_thumbnail,
      size_in_bytes: size_in_bytes ?? this.size_in_bytes,
      updated_at: updated_at ?? this.updated_at,
      created_at: created_at ?? this.created_at,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'folder': folder,
      'path': path,
      'path_thumbnail': path_thumbnail,
      'ftype_id': ftype_id,
      'user_id': user_id,
      'ext': ext,
      'full_path': full_path,
      'full_path_thumbnail': full_path_thumbnail,
      'size_in_bytes': size_in_bytes,
      'updated_at': updated_at,
      'created_at': created_at,
      'id': id,
    };
  }

  static Berkas fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Berkas(
      folder: map['folder'],
      path: map['path'],
      path_thumbnail: map['path_thumbnail'],
      ftype_id: map['ftype_id']?.toInt(),
      user_id: map['user_id']?.toInt(),
      ext: map['ext'],
      full_path: map['full_path'],
      full_path_thumbnail: map['full_path_thumbnail'],
      size_in_bytes: map['size_in_bytes']?.toInt(),
      updated_at: map['updated_at'],
      created_at: map['created_at'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  static Berkas fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Berkas(folder: $folder, path: $path, path_thumbnail: $path_thumbnail, ftype_id: $ftype_id, user_id: $user_id, ext: $ext, full_path: $full_path, full_path_thumbnail: $full_path_thumbnail, size_in_bytes: $size_in_bytes, updated_at: $updated_at, created_at: $created_at, id: $id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Berkas &&
        o.folder == folder &&
        o.path == path &&
        o.path_thumbnail == path_thumbnail &&
        o.ftype_id == ftype_id &&
        o.user_id == user_id &&
        o.ext == ext &&
        o.full_path == full_path &&
        o.full_path_thumbnail == full_path_thumbnail &&
        o.size_in_bytes == size_in_bytes &&
        o.updated_at == updated_at &&
        o.created_at == created_at &&
        o.id == id;
  }

  @override
  int get hashCode {
    return folder.hashCode ^
        path.hashCode ^
        path_thumbnail.hashCode ^
        ftype_id.hashCode ^
        user_id.hashCode ^
        ext.hashCode ^
        full_path.hashCode ^
        full_path_thumbnail.hashCode ^
        size_in_bytes.hashCode ^
        updated_at.hashCode ^
        created_at.hashCode ^
        id.hashCode;
  }
}
