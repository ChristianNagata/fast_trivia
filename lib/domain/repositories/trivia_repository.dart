
import '../entities/quiz_entity.dart';

abstract class TriviaRepository {
  Future<QuizEntity> getQuiz(int id);
}