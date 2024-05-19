import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme.dart';
import 'package:simpsons_app/app/routes/app_routes.dart';
import 'package:simpsons_app/app/service_locator/service_locator.dart';
import 'package:simpsons_app/features/bottom_navigation_bar/provider/bottom_navigation_bar_provider.dart';
import 'package:simpsons_app/features/simpsons/providers/simpson_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "envs/.env");
  serviceLocatorInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SimpsonProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavigationBarProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: AppTheme().getLightTheme(),
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initialRoute,
      ),
    );
  }
}
