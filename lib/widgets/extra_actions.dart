import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goalsflutter/blocs/goals/goals.dart';
import 'package:goalsflutter/models/models.dart';

class ExtraActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsBloc, GoalsState>(
      builder: (context, state) {
        if (state is GoalsLoaded) {
          bool allComplete = state.goals.every((goal) => goal.complete);
          return PopupMenuButton<ExtraAction>(
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  BlocProvider.of<GoalsBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<GoalsBloc>(context).add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                value: ExtraAction.toggleAllComplete,
                child: Text(
                    allComplete ? 'Mark all incomplete' : 'Mark all complete'),
              ),
              PopupMenuItem<ExtraAction>(
                value: ExtraAction.clearCompleted,
                child: Text('Clear completed'),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
