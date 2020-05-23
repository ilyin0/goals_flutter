import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:goals_repository/goals_repository.dart';
import 'package:goalsflutter/blocs/filtered_goals/filtered_goals.dart';
import 'package:goalsflutter/blocs/goals/goals.dart';
import 'package:goalsflutter/models/models.dart';
import 'package:meta/meta.dart';

class FilteredGoalsBloc extends Bloc<FilteredGoalsEvent, FilteredGoalsState> {
  final GoalsBloc _goalsBloc;
  StreamSubscription _goalsSubscription;

  FilteredGoalsBloc({@required GoalsBloc goalsBloc})
      : assert(goalsBloc != null),
        _goalsBloc = goalsBloc {
    _goalsSubscription = goalsBloc.listen((state) {
      if (state is GoalsLoaded) {
        add(UpdateGoals((goalsBloc.state as GoalsLoaded).goals));
      }
    });
  }

  @override
  FilteredGoalsState get initialState {
    final currentState = _goalsBloc.state;
    return currentState is GoalsLoaded
        ? FilteredGoalsLoaded(currentState.goals, VisibilityFilter.all)
        : FilteredGoalsLoading();
  }

  @override
  Stream<FilteredGoalsState> mapEventToState(FilteredGoalsEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateGoals) {
      yield* _mapGoalsUpdatedToState(event);
    }
  }

  Stream<FilteredGoalsState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    final currentState = _goalsBloc.state;
    if (currentState is GoalsLoaded) {
      yield FilteredGoalsLoaded(
        _mapGoalsToFilteredGoals(currentState.goals, event.filter),
        event.filter,
      );
    }
  }

  Stream<FilteredGoalsState> _mapGoalsUpdatedToState(
    UpdateGoals event,
  ) async* {
    final visibilityFilter = state is FilteredGoalsLoaded
        ? (state as FilteredGoalsLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredGoalsLoaded(
      _mapGoalsToFilteredGoals(
        (_goalsBloc.state as GoalsLoaded).goals,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Goal> _mapGoalsToFilteredGoals(
      List<Goal> goals, VisibilityFilter filter) {
    return goals.where((goal) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !goal.complete;
      } else {
        return goal.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _goalsSubscription?.cancel();
    return super.close();
  }
}
