abstract class StoryState {}

class StoryInitial extends StoryState {}

class StoryLoading extends StoryState {}

class StoryPlaying extends StoryState {}

class QuizVisible extends StoryState {}

class WrongAnswerState extends StoryState {}

class SuccessState extends StoryState {}

class ErrorState extends StoryState {
  final String message;

  ErrorState(this.message);
}
