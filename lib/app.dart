import 'package:flutter/cupertino.dart';
import 'package:nutrition_tracker/screens/analytics_screen.dart';
import 'package:nutrition_tracker/screens/home_screen.dart';
import 'package:nutrition_tracker/screens/profile_screen.dart';
import 'package:nutrition_tracker/utils/custom_colors.dart';

List<Widget> screens = const [
  HomeScreen(),
  AnalyticsScreen(),
  ProfileScreen(),
];

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Nutrition Tracker',
      theme: const CupertinoThemeData(
          scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor,
          brightness: Brightness.dark),
      home: _bottomTabNavigator(context),
    );
  }
}

Widget _bottomTabNavigator(BuildContext context) => CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      iconSize: 24,
      activeColor: CustomColors.primaryColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.square_favorites),
          activeIcon: Icon(CupertinoIcons.square_favorites_fill),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chart_pie),
          activeIcon: Icon(CupertinoIcons.chart_pie_fill),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          activeIcon: Icon(CupertinoIcons.person_solid),
        ),
      ],
    ),
    tabBuilder: (context, index) => screens[index]);
