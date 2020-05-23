import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals_repository/goals_repository.dart';
import 'package:goalsflutter/blocs/blocs.dart';

import 'home_screen.dart';
import 'screens.dart';

class AppScreen extends StatelessWidget {
  final String id;

  AppScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GoalsBloc>(
          create: (context) {
            return GoalsBloc(
              goalsRepository: FirebaseGoalsRepository.withId(id: id),
            )..add(LoadGoals());
          },
        )
      ],
      child: MaterialApp(
        title: 'Goals',
        routes: {
          '/': (context) {
            return BlocBuilder<GoalsBloc, GoalsState>(
              builder: (context, state) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<TabBloc>(
                      create: (context) => TabBloc(),
                    ),
                    BlocProvider<FilteredGoalsBloc>(
                      create: (context) => FilteredGoalsBloc(
                        goalsBloc: BlocProvider.of<GoalsBloc>(context),
                      ),
                    ),
                    BlocProvider<StatsBloc>(
                      create: (context) => StatsBloc(
                        goalsBloc: BlocProvider.of<GoalsBloc>(context),
                      ),
                    ),
                  ],
                  child: HomeScreen(),
                );
              },
            );
          },
          '/addGoal': (context) {
            return AddEditScreen(
              onSave: (task, note) {
                BlocProvider.of<GoalsBloc>(context).add(
                  AddGoal(Goal(task, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}
