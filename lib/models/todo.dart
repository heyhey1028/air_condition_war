import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/timestamp.dart';
import '../utils/json_converters/union_timestamp.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    @Default('') String todoId,
    @Default('') String userId,
    @Default('') String title,
    @Default('') String description,
    @timestampConverter DateTime? dueDateTime,
    @Default(false) bool isDone,
    @alwaysUseServerTimestampUnionTimestampConverter
    @Default(UnionTimestamp.serverTimestamp())
        UnionTimestamp updatedAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  factory Todo.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Todo.fromJson(<String, dynamic>{
      ...data,
      'todoId': ds.id,
    });
  }

  const Todo._();
}
