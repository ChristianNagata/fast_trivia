import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/question_entity.dart';
import '../../controllers/trivia_notifier.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.readOnly,
  });

  final QuestionEntity question;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    var notifier = context.watch<TriviaNotifier>();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  question.titulo!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                Builder(builder: (context) {
                  if (!readOnly) return Container();
                  Icon icon = const Icon(
                    Icons.check,
                    color: Colors.lightGreen,
                  );

                  if (!question.isQuestionCorrect) {
                    icon = const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                    );
                  }
                  return icon;
                })
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${question.id} - ${question.pergunta!}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            for (var option in question.alternativas!)
              Builder(builder: (context) {
                int? groupValue = question.valorSelecionado;
                Color? activeColor;
                if (readOnly) {
                  if (question.isQuestionCorrect) {
                    groupValue = question.valorSelecionado;
                    activeColor = Colors.lightGreen;
                  } else {
                    if (option.id == question.valorSelecionado) {
                      groupValue = question.valorSelecionado;
                      activeColor = Colors.redAccent;
                    }
                    if (option.id == question.gabarito) {
                      groupValue = question.gabarito;
                      activeColor = Colors.lightGreen;
                    }
                  }
                }

                return RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    option.titulo!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: option.id!,
                  groupValue: groupValue,
                  activeColor: activeColor,
                  onChanged: (value) {
                    readOnly
                        ? null
                        : notifier.changeAlternative(value!, question);
                  },
                );
              })
          ],
        ),
      ),
    );
  }
}
