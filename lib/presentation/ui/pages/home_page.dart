import 'package:fast_trivia/presentation/controllers/trivia_notifier.dart';
import 'package:fast_trivia/presentation/ui/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    var notifier = Provider.of<TriviaNotifier>(context, listen: false);
    notifier.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    var notifier = context.watch<TriviaNotifier>();
    Color primary = Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QuizPage()),
          );
          notifier.getHistory();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Respondidos'),
      ),
      body: notifier.history.isEmpty
          ? Center(
              child: Icon(
                Icons.folder_copy,
                size: 64,
                color: primary.withOpacity(.1),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: notifier.history.length,
              itemBuilder: (BuildContext context, int index) {
                var quiz = notifier.history[index];

                var correct = quiz.correctAnswers.toString().padLeft(2, '0');
                var total = quiz.questoes!.length.toString().padLeft(2, '0');
                String subtitle = '$correct de $total questões acertas';

                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => QuizPage(quiz: quiz)),
                      );
                    },
                    title: Text(quiz.titulo!),
                    subtitle: Text(subtitle),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
