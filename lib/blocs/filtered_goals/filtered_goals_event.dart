import 'package:equatable/equatable.dart';
import 'package:goals_repository/goals_repository.dart';
import 'package:goalsflutter/models/models.dart';

abstract class FilteredGoalsEvent extends Equatable {
  const FilteredGoalsEvent();
}

class UpdateFilter extends FilteredGoalsEvent {
  final VisibilityFilter filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateGoals extends FilteredGoalsEvent {
  final List<Goal> todos;

  const UpdateGoals(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'UpdateGoals { todos: $todos }';
}
