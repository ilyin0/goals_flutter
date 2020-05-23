import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:goals_repository/goals_repository.dart';
import 'package:goalsflutter/blocs/goals/goals.dart';
import 'package:meta/meta.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  final GoalsRepository _goalsRepository;
  StreamSubscription _goalsSubscription;

  GoalsBloc({@required GoalsRepository goalsRepository})
      : assert(goalsRepository != null),
        _goalsRepository = goalsRepository;

  @override
  GoalsState get initialState => GoalsLoading();

  @override
  Stream<GoalsState> mapEventToState(GoalsEvent event) async* {
    if (event is LoadGoals) {
      yield* _mapLoadGoalsToState();
    } else if (event is AddGoal) {
      yield* _mapAddGoalToState(event);
    } else if (event is UpdateGoal) {
      yield* _mapUpdateGoalToState(event);
    } else if (event is DeleteGoal) {
      yield* _mapDeleteGoalToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is GoalsUpdated) {
      yield* _mapGoalsUpdateToState(event);
    }
  }

  Stream<GoalsState> _mapLoadGoalsToState() async* {
    _goalsSubscription?.cancel();
    _goalsSubscription = _goalsRepository.goals().listen(
          (goals) => add(GoalsUpdated(goals)),
        );
  }

  Stream<GoalsState> _mapAddGoalToState(AddGoal event) async* {
    _goalsRepository.addNewGoal(event.goal);
  }

  Stream<GoalsState> _mapUpdateGoalToState(UpdateGoal event) async* {
    _goalsRepository.updateGoal(event.updatedGoal);
  }

  Stream<GoalsState> _mapDeleteGoalToState(DeleteGoal event) async* {
    _goalsRepository.deleteGoal(event.goal);
  }

  Stream<GoalsState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is GoalsLoaded) {
      final allComplete = currentState.goals.every((goal) => goal.complete);
      final List<Goal> updatedGoals = currentState.goals
          .map((goal) => goal.copyWith(complete: !allComplete))
          .toList();
      updatedGoals.forEach((updatedGoal) {
        _goalsRepository.updateGoal(updatedGoal);
      });
    }
  }

  Stream<GoalsState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is GoalsLoaded) {
      final List<Goal> completedGoals =
          currentState.goals.where((goal) => goal.complete).toList();
      completedGoals.forEach((completedGoal) {
        _goalsRepository.deleteGoal(completedGoal);
      });
    }
  }

  Stream<GoalsState> _mapGoalsUpdateToState(GoalsUpdated event) async* {
    yield GoalsLoaded(event.goals);
  }

  @override
  Future<void> close() {
    _goalsSubscription?.cancel();
    return super.close();
  }
}
