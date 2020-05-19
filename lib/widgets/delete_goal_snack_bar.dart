import 'package:flutter/material.dart';
import 'package:goals_repository/goals_repository.dart';

class DeleteGoalSnackBar extends SnackBar {
  DeleteGoalSnackBar({
    Key key,
    @required Goal goal,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Deleted ${goal.task}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}
