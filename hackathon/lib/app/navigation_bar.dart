import 'package:flutter/material.dart';
import 'package:hackathon/app/analytics/analytics_screen.dart';
import 'package:hackathon/app/home/screens/home_screen.dart';
import 'package:hackathon/style/colors.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  final List<Widget> screens = [
    const HomeScreen(),
    const AnalyticsScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: ColorsApp.primaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: ColorsApp.ternaryColor,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_tree_rounded),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
            ),
          ]),
    );
  }
}
