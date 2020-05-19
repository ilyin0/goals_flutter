import 'package:equatable/equatable.dart';
import 'package:goals_repository/goals_repository.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<Goal> goals;

  const UpdateStats(this.goals);

  @override
  List<Object> get props => [goals];

  @override
  String toString() => 'UpdateStats { goals: $goals }';
}
