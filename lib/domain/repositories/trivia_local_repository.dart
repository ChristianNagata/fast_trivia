

import 'package:fast_trivia/domain/entities/quiz_entity.dart';

abstract class TriviaLocalRepository {
  Future<List<QuizEntity>> getQuizHistory();

  Future<void> storeQuiz(QuizEntity quiz);
}