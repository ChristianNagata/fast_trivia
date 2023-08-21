import 'package:fast_trivia/domain/entities/quiz_entity.dart';
import 'package:fast_trivia/domain/repositories/trivia_local_repository.dart';
import 'package:hive/hive.dart';

class TriviaHiveRepository implements TriviaLocalRepository {
  final Box _box;

  TriviaHiveRepository(this._box);

  @override
  Future<List<QuizEntity>> getQuizHistory() async {
    List data = _box.get('history', defaultValue: []);

    var dataParsed = data.map((e) => _keysToString(e)).toList();

    var entities = dataParsed.map((e) => QuizEntity.fromJson(e)).toList();

    return entities;
  }

  @override
  Future<void> storeQuiz(QuizEntity quiz) async {
    var history = await getQuizHistory();
    history.add(quiz);
    var historyJson = history.map((e) => e.toJson()).toList();

    await _box.put('history', historyJson);
  }

  Map<String, dynamic> _keysToString(Map<dynamic, dynamic> json) {
    Map<String, dynamic> jsonParsed = {};
    json.forEach((key, value) {
      if (value is List) {
        List<Map<String, dynamic>> valuesParsed =
            value.map((e) => _keysToString(e)).toList();
        jsonParsed[key.toString()] = valuesParsed;
        return;
      }
      jsonParsed[key.toString()] = value;
    });
    return jsonParsed;
  }
}
