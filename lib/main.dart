import 'package:flutter/material.dart';
import 'hidden_drawer_menu.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_application_1/Sheets/number_change_sheets_api.dart';
import 'package:flutter_application_1/Sheets/reconnection_sheets_api.dart';
import 'package:flutter_application_1/Sheets/relocation_sheets_api.dart';
import 'package:flutter_application_1/Sheets/termination_sheets_api.dart';
import 'package:flutter_application_1/Sheets/package_change_Sheets_api.dart';
import 'package:flutter_application_1/Sheets/service_sheets_api.dart';

import 'package/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceVacation.init();
  await PackageChange.init();
  await NumberChange.init();
  await Reconnection.init();
  await Relocation.init();
  await Termination.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Office',
      home: Navigator(
        initialRoute: 'settings',
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case 'settings':
              return MaterialPageRoute(builder: (_) => SettingsPage());
            case 'hiddenDrawer':
              return MaterialPageRoute(
                  builder: (_) =>
                      const HiddenDrawer(decoration: BoxDecoration()));
            default:
              throw Exception('Invalid route: ${routeSettings.name}');
          }
        },
      ),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      routes: {
        '/settings': (context) => SettingsPage(),
        '/hiddenDrawer': (context) => HiddenDrawer(decoration: BoxDecoration()),
      },
    );
  }
}
