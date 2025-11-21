import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/tasks_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo Calendar',
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginScreen(),
        '/register': (_) => RegisterScreen(),
        '/calendar': (_) => CalendarScreen(),
        '/tasks': (_) => TasksScreen(),
      },
    );
  }
}
