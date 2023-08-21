import 'package:fast_trivia/domain/entities/quiz_entity.dart';
import 'package:flutter/material.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage(this.quiz, {Key? key}) : super(key: key);

  final QuizEntity quiz;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: Navigator.of(context).pop,
        child: const Icon(Icons.check),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primary.withOpacity(.1), width: 2),
              ),
              child: Center(
                child: Text(
                  '${quiz.correctAnswers}/${quiz.questoes!.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 50,
                    color: primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Você acertou ',
                  style: TextStyle(fontSize: 22, color: primary),
                ),
                Text(
                  quiz.correctAnswers.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    color: primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' das ',
                  style: TextStyle(fontSize: 22, color: primary),
                ),
                Text(
                  quiz.questoes!.length.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    color: primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' questões!',
                  style: TextStyle(fontSize: 22, color: primary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
