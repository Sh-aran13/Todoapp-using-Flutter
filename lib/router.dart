import 'package:go_router/go_router.dart';
import './providers/auth_provider.dart';
import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/home_screen.dart';
import './screens/task_list_screen.dart';
import './screens/logging_out_screen.dart';

class AppRouter {
  final AuthProvider authProvider;
  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    refreshListenable: authProvider,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/tasks',
        builder: (context, state) => const TaskListScreen(),
      ),
      GoRoute(
        path: '/logout',
        builder: (context, state) => const LoggingOutScreen(),
      ),
    ],
    redirect: (context, state) {
      final bool isAuthenticated = authProvider.isAuthenticated;
      final String location = state.matchedLocation;

      // Define public pages that can be accessed without authentication.
      final bool isPublicPage = location == '/login' || location == '/register';

      // If the user is not authenticated and is not on a public page,
      // redirect them to the login page.
      if (!isAuthenticated && !isPublicPage) {
        return '/login';
      }

      // If the user is authenticated and tries to go to a public page,
      // redirect them to the home page.
      if (isAuthenticated && isPublicPage) {
        return '/';
      }

      // No redirect is needed in all other cases.
      return null;
    },
  );
}