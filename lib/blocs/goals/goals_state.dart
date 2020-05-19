import 'package:equatable/equatable.dart';
import 'package:goals_repository/goals_repository.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();

  @override
  List<Object> get props => [];
}

class GoalsLoading extends GoalsState {}

class GoalsLoaded extends GoalsState {
  final List<Goal> goals;

  const GoalsLoaded([this.goals = const []]);

  @override
  List<Object> get props => [goals];

  @override
  String toString() => 'GoalsLoaded { goals: $goals }';
}

class GoalsNotLoaded extends GoalsState {}
