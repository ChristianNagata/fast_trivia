import 'package:fast_trivia/domain/entities/question_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_entity.freezed.dart';
part 'quiz_entity.g.dart';

@freezed
abstract class QuizEntity with _$QuizEntity {
  // dart run build_runner build --delete-conflicting-outputs
  QuizEntity._();

  factory QuizEntity({
    int? id,
    String? titulo,
    List<QuestionEntity>? questoes,
  }) = _QuizEntity;

  factory QuizEntity.fromJson(Map<String, dynamic> json) =>
      _$QuizEntityFromJson(json);

  bool get isFormValid {
    List<bool> values =
        questoes!.map((e) => e.valorSelecionado != null).toList();
    return values.every((e) => e == true);
  }

  int get correctAnswers {
    int correct = 0;
    for (var questao in questoes!) {
      if (questao.isQuestionCorrect) correct++;
    }
    return correct;
  }
}
