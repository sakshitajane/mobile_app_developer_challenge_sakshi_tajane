import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_app_developer_challenge_sakshi_tajane/core/data/story_data.dart';
import 'package:mobile_app_developer_challenge_sakshi_tajane/features/story/bloc/story_bloc.dart';
import 'package:mobile_app_developer_challenge_sakshi_tajane/features/story/bloc/story_event.dart';
import 'package:mobile_app_developer_challenge_sakshi_tajane/features/story/bloc/story_state.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Widget buildOptionButton(String option) {
    return GestureDetector(
      onTap: () {
        context.read<StoryBloc>().add(SelectAnswerEvent(option));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.deepPurple.shade100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(option, style: const TextStyle(fontSize: 18)),
            const Icon(Icons.radio_button_unchecked),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = StoryData.quiz;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Color(0xFF36165E)),
        title: const Text(
          "AI Story Buddy",
          style: TextStyle(
            color: Color(0xFF36165E),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.account_circle_outlined,
              color: Color(0xFF36165E),
            ),
          ),
        ],
      ),

      body: BlocConsumer<StoryBloc, StoryState>(
        listener: (context, state) {
          if (state is WrongAnswerState) {
            HapticFeedback.heavyImpact();

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Oops! Try Again 😊")));
          }

          if (state is SuccessState) {
            _confettiController.play();
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
              ),

              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    /// Buddy Image
                    Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          "assets/images/robot.png",
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) {
                            return const Icon(
                              Icons.smart_toy,
                              size: 120,
                              color: Color(0xFF6F2BC2),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Story Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.deepPurple.shade100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "STORY",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.menu_book_outlined,
                                color: Colors.deepPurple.shade200,
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Text(
                            StoryData.storyText,
                            style: const TextStyle(fontSize: 18, height: 1.7),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// Loading
                    if (state is StoryLoading)
                      const Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text("✨ Pip is getting your story ready..."),
                        ],
                      ),

                    /// Initial Button
                    if (state is StoryInitial)
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<StoryBloc>().add(ReadStoryEvent());
                          },
                          icon: const Icon(
                            Icons.volume_up,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Read Me a Story",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6F2BC2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 25),

                    /// Playing
                    if (state is StoryPlaying)
                      const Text(
                        "🎧 Listening to Story...",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    /// Quiz
                    if (state is QuizVisible || state is WrongAnswerState)
                      Column(
                        children: [
                          const SizedBox(height: 20),

                          Text(
                            quiz.question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          ...quiz.options.map(
                            (option) => buildOptionButton(option),
                          ),
                        ],
                      ),

                    /// Success
                    if (state is SuccessState)
                      Column(
                        children: [
                          const SizedBox(height: 20),

                          const Text(
                            "🎉 Great Job!",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Pip found his Blue Gear!",
                            style: TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 20),

                          Image.asset(
                            "assets/images/robot.png",
                            height: 150,
                            errorBuilder: (_, __, ___) {
                              return const Icon(
                                Icons.sentiment_very_satisfied,
                                size: 120,
                                color: Colors.green,
                              );
                            },
                          ),
                        ],
                      ),

                    if (state is ErrorState)
                      Column(
                        children: [
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<StoryBloc>().add(ReadStoryEvent());
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
