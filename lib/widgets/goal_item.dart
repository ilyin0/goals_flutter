import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goals_repository/goals_repository.dart';

class GoalItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Goal goal;

  GoalItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__goal_item_${goal.id}'),
      onDismissed: onDismissed,
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.cancel),
      ),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        child: Icon(Icons.cancel),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          activeColor: Colors.green,
          value: goal.complete,
          onChanged: onCheckboxChanged,
        ),
        title: Hero(
          tag: '${goal.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              goal.task,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: goal.note.isNotEmpty
            ? Text(
                goal.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subhead,
              )
            : null,
      ),
    );
  }
}
