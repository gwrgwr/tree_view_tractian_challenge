// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssetsModel {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final String? sensorType;
  AssetsModel({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
  });

  AssetsModel copyWith({
    String? id,
    String? name,
    String? locationId,
    String? parentId,
    String? sensorType,
  }) {
    return AssetsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      locationId: locationId ?? this.locationId,
      parentId: parentId ?? this.parentId,
      sensorType: sensorType ?? this.sensorType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'locationId': locationId,
      'parentId': parentId,
      'sensorType': sensorType,
    };
  }

  factory AssetsModel.fromMap(Map<String, dynamic> map) {
    return AssetsModel(
      id: map['id'] as String,
      name: map['name'] as String,
      locationId: map['locationId'] != null ? map['locationId'] as String : null,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      sensorType: map['sensorType'] != null ? map['sensorType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetsModel.fromJson(Map<String, dynamic> json) {
    return AssetsModel(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
    );
  }

  @override
  String toString() {
    return 'AssetsModel(id: $id, name: $name, locationId: $locationId, parentId: $parentId, sensorType: $sensorType)';
  }

  @override
  bool operator ==(covariant AssetsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.locationId == locationId &&
      other.parentId == parentId &&
      other.sensorType == sensorType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      locationId.hashCode ^
      parentId.hashCode ^
      sensorType.hashCode;
  }
}
