import 'package:fast_trivia/domain/datasources/trivia_datasource.dart';
import 'package:fast_trivia/domain/entities/quiz_entity.dart';
import 'package:fast_trivia/domain/repositories/trivia_repository.dart';

class TriviaRepositoryImpl implements TriviaRepository {
  final TriviaDatasource _triviaDatasource;

  TriviaRepositoryImpl(this._triviaDatasource);

  @override
  Future<QuizEntity> getQuiz(int id) async {
    var data = await _triviaDatasource.getQuiz(id);

    var entity = QuizEntity.fromJson(data);

    return entity;
  }
}
