// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CompaniesModel {
  final String id;
  final String name;
  CompaniesModel({
    required this.id,
    required this.name,
  });

  CompaniesModel copyWith({
    String? id,
    String? name,
  }) {
    return CompaniesModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CompaniesModel.fromMap(Map<String, dynamic> map) {
    return CompaniesModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompaniesModel.fromJson(String source) => CompaniesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CompaniesModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant CompaniesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
