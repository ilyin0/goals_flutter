import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../goals_repository.dart';
import 'goals_repository.dart';
import 'entities/entities.dart';

class FirebaseGoalsRepository implements GoalsRepository {
  final CollectionReference goalCollection;

  FirebaseGoalsRepository(this.goalCollection);

  FirebaseGoalsRepository.withNameOfCollection({String nameOfCollection})
      : goalCollection = Firestore.instance.collection(nameOfCollection);

  FirebaseGoalsRepository.withId({String id})
      : goalCollection = Firestore.instance
            .collection('goals')
            .document(id)
            .collection('goals');

  @override
  Future<void> addNewGoal(Goal goal) {
    return goalCollection.add(goal.toEntity().toDocument());
  }

  @override
  Future<void> deleteGoal(Goal goal) async {
    return goalCollection.document(goal.id).delete();
  }

  @override
  Stream<List<Goal>> goals() {
    return goalCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Goal.fromEntity(GoalEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateGoal(Goal update) {
    return goalCollection
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }
}
