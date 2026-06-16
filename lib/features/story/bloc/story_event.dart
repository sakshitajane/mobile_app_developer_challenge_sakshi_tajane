abstract class StoryEvent {}

class ReadStoryEvent extends StoryEvent {}

class StoryCompletedEvent extends StoryEvent {}

class SelectAnswerEvent extends StoryEvent {
  final String answer;

  SelectAnswerEvent(this.answer);
}
