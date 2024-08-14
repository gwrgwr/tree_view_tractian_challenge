// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocationModel {
  final String id;
  final String name;
  final String? parentId;
  LocationModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  LocationModel copyWith({
    String? id,
    String? name,
    String? parentId,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
    );
  }

  @override
  String toString() => 'LocationModel(id: $id, name: $name, parentId: $parentId)';

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.parentId == parentId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ parentId.hashCode;
}
