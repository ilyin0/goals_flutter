import 'package:equatable/equatable.dart';
import 'package:goals_repository/goals_repository.dart';

abstract class GoalsEvent extends Equatable {
  const GoalsEvent();

  @override
  List<Object> get props => [];
}

class LoadGoals extends GoalsEvent {}

class AddGoal extends GoalsEvent {
  final Goal goal;

  const AddGoal(this.goal);

  @override
  List<Object> get props => [goal];

  @override
  String toString() => 'AddGoal { goal: $goal }';
}

class UpdateGoal extends GoalsEvent {
  final Goal updatedGoal;

  const UpdateGoal(this.updatedGoal);

  @override
  List<Object> get props => [updatedGoal];

  @override
  String toString() => 'UpdateGoal { updatedGoal: $updatedGoal }';
}

class DeleteGoal extends GoalsEvent {
  final Goal goal;

  const DeleteGoal(this.goal);

  @override
  List<Object> get props => [goal];

  @override
  String toString() => 'DeleteGoal { goal: $goal }';
}

class ClearCompleted extends GoalsEvent {}

class ToggleAll extends GoalsEvent {}

class GoalsUpdated extends GoalsEvent {
  final List<Goal> goals;

  const GoalsUpdated(this.goals);

  @override
  List<Object> get props => [goals];
}
