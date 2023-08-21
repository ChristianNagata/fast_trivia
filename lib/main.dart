import 'package:fast_trivia/core/inject.dart';
import 'package:fast_trivia/presentation/controllers/trivia_notifier.dart';
import 'package:fast_trivia/presentation/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveConfig.init();

  await Inject.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TriviaNotifier>(
          create: (_) => GetIt.I.get<TriviaNotifier>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Trivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
