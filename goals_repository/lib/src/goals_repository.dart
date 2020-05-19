import 'dart:async';

import '../goals_repository.dart';

abstract class GoalsRepository {
  Future<void> addNewGoal(Goal goal);

  Future<void> deleteGoal(Goal goal);

  Stream<List<Goal>> goals();

  Future<void> updateGoal(Goal goal);
}
