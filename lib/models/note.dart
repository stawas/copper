import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part '../generated/models/note.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Note extends HiveObject {
  @HiveField(0, defaultValue: "")
  String id;

  @HiveField(1, defaultValue: "")
  String name;
  
  @HiveField(2, defaultValue: "")
  String content;

  @HiveField(3, defaultValue: 0)
  int updateDate;

  Note({required this.id, required this.name, required this.content, required this.updateDate});

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
