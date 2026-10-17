import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'data/models/quiz_result.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
import 'screens/review_screen.dart';
import 'widgets/app_background.dart';

class KuisinApp extends StatelessWidget {
  const KuisinApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider diletakkan di atas MaterialApp agar state bertahan
    // ketika berpindah halaman maupun saat orientasi layar berubah.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) => MaterialApp(
          title: 'Kuisin',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: theme.mode,
          initialRoute: AppRoutes.home,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    Widget page(BuildContext context) {
      QuizResult? resultArg() =>
          settings.arguments as QuizResult? ??
          context.read<QuizProvider>().lastResult;

      switch (settings.name) {
        case AppRoutes.quiz:
          return const QuizScreen();
        case AppRoutes.result:
          final result = resultArg();
          return result == null
              ? const HomeScreen()
              : ResultScreen(result: result);
        case AppRoutes.review:
          final result = resultArg();
          return result == null
              ? const HomeScreen()
              : ReviewScreen(result: result);
        case AppRoutes.history:
          return const HistoryScreen();
        case AppRoutes.home:
        default:
          return const HomeScreen();
      }
    }

    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, _, _) => AppBackground(child: page(context)),
      transitionsBuilder: (context, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0.06, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
