import 'package:equatable/equatable.dart';
import 'package:goals_repository/goals_repository.dart';
import 'package:goalsflutter/models/models.dart';

abstract class FilteredGoalsState extends Equatable {
  const FilteredGoalsState();

  @override
  List<Object> get props => [];
}

class FilteredGoalsLoading extends FilteredGoalsState {}

class FilteredGoalsLoaded extends FilteredGoalsState {
  final List<Goal> filteredGoals;
  final VisibilityFilter activeFilter;

  const FilteredGoalsLoaded(
    this.filteredGoals,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredGoals, activeFilter];

  @override
  String toString() {
    return 'FilteredGoalsLoaded { filteredGoals: $filteredGoals, activeFilter: $activeFilter }';
  }
}
