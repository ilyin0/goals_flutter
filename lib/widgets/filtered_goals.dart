import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goalsflutter/blocs/blocs.dart';
import 'package:goalsflutter/widgets/widgets.dart';
import 'package:goalsflutter/screens/screens.dart';

class FilteredGoals extends StatelessWidget {
  FilteredGoals({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredGoalsBloc, FilteredGoalsState>(
      builder: (context, state) {
        if (state is FilteredGoalsLoading) {
          return LoadingIndicator();
        } else if (state is FilteredGoalsLoaded) {
          final goals = state.filteredGoals;
          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              return GoalItem(
                goal: goal,
                onDismissed: (direction) {
                  BlocProvider.of<GoalsBloc>(context).add(DeleteGoal(goal));
                  Scaffold.of(context).showSnackBar(DeleteGoalSnackBar(
                    goal: goal,
                    onUndo: () =>
                        BlocProvider.of<GoalsBloc>(context).add(AddGoal(goal)),
                  ));
                },
                onTap: () async {
                  final removedGoal = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: goal.id);
                    }),
                  );
                  if (removedGoal != null) {
                    Scaffold.of(context).showSnackBar(
                      DeleteGoalSnackBar(
                        goal: goal,
                        onUndo: () => BlocProvider.of<GoalsBloc>(context)
                            .add(AddGoal(goal)),
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<GoalsBloc>(context).add(
                    UpdateGoal(goal.copyWith(complete: !goal.complete)),
                  );
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
