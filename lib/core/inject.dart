import 'package:fast_trivia/data/datasources/trivia_datasource_impl.dart';
import 'package:fast_trivia/domain/datasources/trivia_datasource.dart';
import 'package:fast_trivia/domain/repositories/trivia_local_repository.dart';
import 'package:fast_trivia/domain/repositories/trivia_repository.dart';
import 'package:fast_trivia/presentation/controllers/trivia_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../data/repositories/trivia_hive_repository.dart';
import '../data/repositories/trivia_repository_impl.dart';

abstract class Inject {
  static init() async {
    final GetIt getIt = GetIt.instance;

    Box box = await Hive.openBox('quizBox');

    // datasources
    getIt.registerLazySingleton<TriviaDatasource>(
      () => TriviaDatasourceImpl(),
    );

    // repositories
    getIt.registerLazySingleton<TriviaRepository>(
      () => TriviaRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<TriviaLocalRepository>(
      () => TriviaHiveRepository(box),
    );

    // controllers
    getIt.registerLazySingleton<TriviaNotifier>(
      () => TriviaNotifier(getIt(), getIt()),
    );
  }
}
