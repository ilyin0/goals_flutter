import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goals_repository/goals_repository.dart';
import 'package:goalsflutter/style/style.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Goal goal;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.goal,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          isEditing ? 'Edit Goal' : 'Add Goal',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                autocorrect: true,
                cursorColor: themeColor,
                initialValue: isEditing ? widget.goal.task : '',
                autofocus: !isEditing,
                style: textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'What needs to be done?',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeColor, style: BorderStyle.solid)),
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                autocorrect: true,
                initialValue: isEditing ? widget.goal.note : '',
                maxLines: 10,
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Additional Notes...',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeColor, style: BorderStyle.solid)),
                ),
                cursorColor: themeColor,
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        tooltip: isEditing ? 'Save changes' : 'Add Goal',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_task, _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
