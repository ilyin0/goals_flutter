import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GoalEntity extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  const GoalEntity(this.task, this.id, this.note, this.complete);

  Map<String, Object> toJson() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "id": id,
    };
  }

  @override
  List<Object> get props => [complete, id, note, task];

  @override
  String toString() {
    return 'TodoEntity { complete: $complete, task: $task, note: $note, id: $id }';
  }

  static GoalEntity fromJson(Map<String, Object> json) {
    return GoalEntity(
      json["task"] as String,
      json["id"] as String,
      json["note"] as String,
      json["complete"] as bool,
    );
  }

  static GoalEntity fromSnapshot(DocumentSnapshot snap) {
    return GoalEntity(
      snap.data['task'],
      snap.documentID,
      snap.data['note'],
      snap.data['complete'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
    };
  }
}
