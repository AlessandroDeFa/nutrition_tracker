import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tracker/blocs/analytics_bloc/validate_analytics_form/analytics_form_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/validate_form/profile_form_bloc.dart';
import 'package:nutrition_tracker/blocs/profile_form/submit_form/submit_form_bloc.dart';
import 'package:nutrition_tracker/cubits/switch_theme/switch_theme_cubit.dart';
import 'package:nutrition_tracker/screens/analytics_screen.dart';
import 'package:nutrition_tracker/screens/home_screen.dart';
import 'package:nutrition_tracker/screens/profile_screen.dart';
import 'package:nutrition_tracker/utils/app_theme.dart';
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
    return MultiBlocProvider(
      providers: [
        // Switch Theme Cubit
        BlocProvider<SwitchThemeCubit>(create: (_) => SwitchThemeCubit()),
        // Profile Form Bloc
        BlocProvider<ProfileFormBloc>(create: (_) => ProfileFormBloc()),
        // Submit Profile Form Bloc
        BlocProvider<SubmitFormBloc>(create: (_)=> SubmitFormBloc()),
        // Analytics Form Bloc
        BlocProvider<AnalyticsFormBloc>(create: (_) => AnalyticsFormBloc()),
      ],
      child: BlocBuilder<SwitchThemeCubit, SwitchThemeState>(
        builder: (context, state) {
          return CupertinoApp(
            title: 'Nutrition Tracker',
            theme: state.darkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            home: _bottomTabNavigator(context),
          );
        },
      ),
    );
  }
}

Widget _bottomTabNavigator(BuildContext context) =>
    CupertinoTabScaffold(
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
