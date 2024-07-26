import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';

import 'calender_screen.dart';
import 'home_screen.dart';
import 'patients_screen.dart';
import 'profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({
    super.key,
  });

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    super.initState();
    // if (widget.isComingFromLogin) {
    // log("::: layout initState login success :::");
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) async {
    //     final isUserSelectedFulfillmentCenter =
    //         CacheHelper.getString(SharedKeys.fulfillmentCenterId) != null;
    //     if (isUserSelectedFulfillmentCenter) {
    //       return;
    //     }
    //     showFulfillmentCenterPicker(context);
    //   },
    // );
    // }
  }

  int selectedIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CalenderScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).colorScheme.surfaceDim,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
