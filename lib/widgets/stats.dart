import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goalsflutter/blocs/stats/stats.dart';
import 'package:goalsflutter/widgets/widgets.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoading) {
          return LoadingIndicator();
        } else if (state is StatsLoaded) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Completed Goals',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    '${state.numCompleted}',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Active Goals',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "${state.numActive}",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
