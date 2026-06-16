import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/story/bloc/story_bloc.dart';
import 'features/story/screens/story_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Story Buddy',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFF8F9FF),
        ),
        home: const StoryScreen(),
      ),
    );
  }
}
