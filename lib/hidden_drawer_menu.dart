import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/numberChange_page.dart';
import 'package:flutter_application_1/pages/reconnection_page.dart';
import 'package:flutter_application_1/pages/relocation_page.dart';
import 'package:flutter_application_1/pages/packageChange_page.dart';
import 'package:flutter_application_1/pages/serviceVacation_page.dart';
import 'package:flutter_application_1/pages/termination_page.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key, required BoxDecoration decoration});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Home Page',
            baseStyle: const TextStyle(
                color: Color.fromARGB(255, 73, 72, 72), fontSize: 13.0),
            selectedStyle: const TextStyle(
                color: Color.fromARGB(255, 15, 14, 14),
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
        const HomePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Package Change',
            baseStyle: const TextStyle(
                color: Color.fromARGB(255, 73, 72, 72), fontSize: 13.0),
            selectedStyle: const TextStyle(
                color: Color.fromARGB(255, 15, 14, 14),
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
        const PackageChangePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Service Vacation',
            baseStyle: const TextStyle(
                color: Color.fromARGB(255, 73, 72, 72), fontSize: 13.0),
            selectedStyle: const TextStyle(
                color: Color.fromARGB(255, 15, 14, 14),
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
        const ServiceVacationPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Termination',
            baseStyle: const TextStyle(
                color: Color.fromARGB(255, 73, 72, 72), fontSize: 13.0),
            selectedStyle: const TextStyle(
                color: Color.fromARGB(255, 15, 14, 14),
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
        const TerminationPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Relocation',
            baseStyle: const TextStyle(
                color: Color.fromARGB(255, 73, 72, 72), fontSize: 13.0),
            selectedStyle: const TextStyle(
                color: Color.fromARGB(255, 15, 14, 14),
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
        const RelocationPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Number Change',
            baseStyle: const TextStyle(
                color: Color.fromARGB(255, 73, 72, 72), fontSize: 13.0),
            selectedStyle: const TextStyle(
                color: Color.fromARGB(255, 15, 14, 14),
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
        const NumberChangePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Reconnection',
            baseStyle: const TextStyle(
                color: Color.fromARGB(255, 73, 72, 72), fontSize: 13.0),
            selectedStyle: const TextStyle(
                color: Color.fromARGB(255, 15, 14, 14),
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
        const ReconnectionPage(),
      ),
      // ScreenHiddenDrawer(
      //   ItemHiddenMenu(
      //       name: 'Settings',
      //       baseStyle: const TextStyle(
      //           color: Color.fromARGB(255, 73, 72, 72), fontSize: 15.0),
      //       selectedStyle: const TextStyle(
      //           color: Color.fromARGB(255, 15, 14, 14),
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold)),
      //   const SettingsPage(),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: const Color.fromARGB(255, 246, 241, 241),
      backgroundColorAppBar: const Color.fromARGB(244, 145, 228, 245),
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 40,
      verticalScalePercent: 80,
    );
  }
}
