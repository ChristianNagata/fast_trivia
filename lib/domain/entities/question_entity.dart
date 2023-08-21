import 'package:freezed_annotation/freezed_annotation.dart';

import 'alternative_entity.dart';

part 'question_entity.freezed.dart';
part 'question_entity.g.dart';

@freezed
abstract class QuestionEntity with _$QuestionEntity {
  // dart run build_runner build --delete-conflicting-outputs
  QuestionEntity._();

  factory QuestionEntity({
    int? id,
    String? titulo,
    String? pergunta,
    int? gabarito,
    List<AlternativeEntity>? alternativas,
    //
    int? valorSelecionado,
  }) = _QuestionEntity;

  factory QuestionEntity.fromJson(Map<String, dynamic> json) =>
      _$QuestionEntityFromJson(json);

  bool get isQuestionCorrect => valorSelecionado == gabarito;

  bool isAlternativeCorrect(int alternative) => alternative == gabarito;
}
