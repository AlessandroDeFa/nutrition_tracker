import 'package:flutter/cupertino.dart';
import 'package:nutrition_tracker/screens/analytics_screen.dart';
import 'package:nutrition_tracker/screens/home_screen.dart';
import 'package:nutrition_tracker/screens/profile_screen.dart';

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
          scaffoldBackgroundColor: Color(0xFF292929),
          brightness: Brightness.dark),
      home: _bottomTabNavigator(context),
    );
  }
}

Widget _bottomTabNavigator(BuildContext context) => CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      iconSize: 24,
      activeColor: Color(0xFF39828D),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.square_list),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chart_pie),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
        ),
      ],
    ),
    tabBuilder: (context, index) => screens[index]);
