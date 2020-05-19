import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goalsflutter/blocs/goals/goals.dart';
import 'package:goalsflutter/screens/screens.dart';
import 'package:goalsflutter/style/style.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsBloc, GoalsState>(
      builder: (context, state) {
        final goal = (state as GoalsLoaded)
            .goals
            .firstWhere((goal) => goal.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: themeColor,
            title: Text('Goal Details'),
            actions: [
              IconButton(
                tooltip: 'Delete Goal',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<GoalsBloc>(context).add(DeleteGoal(goal));
                  Navigator.pop(context, goal);
                },
              )
            ],
          ),
          body: goal == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Checkbox(
                                activeColor: themeColor,
                                value: goal.complete,
                                onChanged: (_) {
                                  BlocProvider.of<GoalsBloc>(context).add(
                                    UpdateGoal(
                                      goal.copyWith(complete: !goal.complete),
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${goal.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      goal.task,
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    ),
                                  ),
                                ),
                                Text(
                                  goal.note,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: themeColor,
            tooltip: 'Edit Goal',
            child: Icon(Icons.edit),
            onPressed: goal == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            onSave: (task, note) {
                              BlocProvider.of<GoalsBloc>(context).add(
                                UpdateGoal(
                                  goal.copyWith(task: task, note: note),
                                ),
                              );
                            },
                            isEditing: true,
                            goal: goal,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
