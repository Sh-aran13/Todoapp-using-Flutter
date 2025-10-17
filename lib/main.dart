import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import './providers/auth_provider.dart';
import './providers/task_provider.dart';
import './router.dart';

void main() {
  // The AuthProvider needs to be initialized before the router.
  final authProvider = AuthProvider();

  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    // The AppRouter depends on AuthProvider, so we pass it in.
    final appRouter = AppRouter(authProvider);

    return MultiProvider(
      providers: [
        // Provide the existing AuthProvider instance.
        ChangeNotifierProvider.value(value: authProvider),
        // Create and provide the TaskProvider.
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Task Manager',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Use the router configuration from our AppRouter class.
        routerConfig: appRouter.router,
      ),
    );
  }
}