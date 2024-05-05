import 'package:sm_project/api/dto/answer_dto.dart';

class QuestionForm {
  final String questionText;
  final List<Answer> answers;
  final String answerType;

  QuestionForm(
      {required this.questionText,
      required this.answers,
      this.answerType = "multipleCoice"});
}
