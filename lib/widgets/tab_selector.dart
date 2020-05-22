import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goalsflutter/models/models.dart';
import 'package:goalsflutter/style/style.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: themeColor,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.goals ? Icons.list : Icons.show_chart,
          ),
          title: Text(
            tab == AppTab.stats ? 'Stats' : 'Goals',
          ),
        );
      }).toList(),
    );
  }
}
