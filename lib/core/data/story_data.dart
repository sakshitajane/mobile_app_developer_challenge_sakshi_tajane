import 'package:mobile_app_developer_challenge_sakshi_tajane/features/story/models/quiz_model.dart';

class StoryData {
  StoryData._();

  static const List<Map<String, dynamic>> stories = [
    {
      "title": "Pip and the Lost Gear",
      "story":
          "Once upon a time, a clever little robot named Pip lost his shiny blue gear in the Whispering Woods.",
      "quiz": {
        "question": "What colour was Pip's lost gear?",
        "options": ["Red", "Green", "Blue", "Yellow"],
        "answer": "Blue",
      },
    },
  ];

  static String get storyText => stories.first["story"];

  static QuizModel get quiz => QuizModel.fromJson(stories.first["quiz"]);
}
