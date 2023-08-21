import 'package:fast_trivia/domain/entities/quiz_entity.dart';
import 'package:fast_trivia/presentation/controllers/trivia_notifier.dart';
import 'package:fast_trivia/presentation/ui/pages/quiz_result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/question_card.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, this.quiz}) : super(key: key);

  final QuizEntity? quiz;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final snackBar = const SnackBar(
    content: Text('Responda todas as questões!'),
  );

  @override
  void initState() {
    super.initState();
    var notifier = Provider.of<TriviaNotifier>(context, listen: false);
    notifier.initQuizPageState(widget.quiz);
  }

  @override
  Widget build(BuildContext context) {
    var notifier = context.watch<TriviaNotifier>();

    return Scaffold(
      floatingActionButton: (widget.quiz != null)
          ? null
          : FloatingActionButton(
              onPressed: () {
                if (!notifier.quiz!.isFormValid) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                notifier.onSubmit();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => QuizResultPage(notifier.quiz!)),
                );
              },
              child: const Icon(Icons.check),
            ),
      appBar: AppBar(
        title: Text(notifier.quiz?.titulo ?? ''),
      ),
      body: notifier.quiz != null
          ? ListView.builder(
              itemCount: notifier.quiz!.questoes!.length,
              padding: const EdgeInsets.all(24),
              itemBuilder: (BuildContext context, int index) {
                var question = notifier.quiz!.questoes![index];
                return QuestionCard(
                  question: question,
                  readOnly: widget.quiz != null,
                );
              },
            )
          : Container(),
    );
  }
}


