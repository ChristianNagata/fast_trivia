import 'dart:convert';

import 'package:fast_trivia/domain/datasources/trivia_datasource.dart';
import 'package:flutter/services.dart';

class TriviaDatasourceImpl implements TriviaDatasource {
  @override
  Future<Map<String, dynamic>> getQuiz(int id) async {
    var jsonString =
        await rootBundle.loadString('assets/mocked/mocked_quizzes.json');

    return jsonDecode(jsonString)['questionario'];
  }
}
