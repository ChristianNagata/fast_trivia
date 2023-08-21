import 'package:fast_trivia/domain/repositories/trivia_local_repository.dart';
import 'package:fast_trivia/domain/repositories/trivia_repository.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/question_entity.dart';
import '../../domain/entities/quiz_entity.dart';

class TriviaNotifier with ChangeNotifier {
  final TriviaRepository _triviaRepository;
  final TriviaLocalRepository _localRepository;

  QuizEntity? _quiz;
  List<QuizEntity> _history = [];

  TriviaNotifier(this._triviaRepository, this._localRepository);

  // getters

  QuizEntity? get quiz => _quiz;

  List<QuizEntity> get history => _history;

  //

  Future<void> initQuizPageState(QuizEntity? quiz) async {
    quiz != null ? _quiz = quiz : getQuiz(1);
  }

  Future<void> getHistory() async {
    _history = await _localRepository.getQuizHistory();
    notifyListeners();
  }

  Future<void> getQuiz(int id) async {
    _quiz = await _triviaRepository.getQuiz(id);
    notifyListeners();
  }

  Future<void> onSubmit() async {
    await _localRepository.storeQuiz(_quiz!);
  }

  void changeAlternative(int value, QuestionEntity question) {
    final newQuestionList = List<QuestionEntity>.from(_quiz!.questoes!);

    int questionIndex = _quiz!.questoes!.indexOf(question);

    newQuestionList[questionIndex] =
        _quiz!.questoes![questionIndex].copyWith(valorSelecionado: value);

    _quiz = _quiz!.copyWith(questoes: newQuestionList);
    notifyListeners();
  }
}
