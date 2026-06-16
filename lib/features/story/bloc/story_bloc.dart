import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_developer_challenge_sakshi_tajane/core/data/story_data.dart';
import 'package:mobile_app_developer_challenge_sakshi_tajane/features/story/services/tts_service.dart';
import 'story_event.dart';
import 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final TtsService _ttsService = TtsService();

  StoryBloc() : super(StoryInitial()) {
    on<ReadStoryEvent>(_onReadStory);
    on<SelectAnswerEvent>(_onSelectAnswer);
  }

  Future<void> _onReadStory(
    ReadStoryEvent event,
    Emitter<StoryState> emit,
  ) async {
    try {
      emit(StoryLoading());

      await _ttsService.initialize();

      emit(StoryPlaying());

      await _ttsService.speak(StoryData.storyText);

      emit(QuizVisible());
    } catch (e) {
      emit(ErrorState("Unable to play story. Please try again."));
    }
  }

  void _onSelectAnswer(SelectAnswerEvent event, Emitter<StoryState> emit) {
    if (event.answer == StoryData.quiz.answer) {
      emit(SuccessState());
    } else {
      emit(WrongAnswerState());

      emit(QuizVisible());
    }
  }

  @override
  Future<void> close() {
    _ttsService.stop();
    return super.close();
  }
}
