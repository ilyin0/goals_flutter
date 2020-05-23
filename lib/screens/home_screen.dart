import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goalsflutter/blocs/authentication/bloc.dart';
import 'package:goalsflutter/blocs/blocs.dart';
import 'package:goalsflutter/models/models.dart';
import 'package:goalsflutter/style/style.dart';
import 'package:goalsflutter/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: themeColor,
            title: Text('Goals'),
            actions: [
              FilterButton(visible: activeTab == AppTab.goals),
              ExtraActions(),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    LoggedOut(),
                  );
                },
              )
            ],
          ),
          body: activeTab == AppTab.goals ? FilteredGoals() : Stats(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.pushNamed(context, '/addGoal');
            },
            child: Icon(Icons.add),
            tooltip: 'Add Goal',
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}
