import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_game/blocs/game_bloc.dart';
import 'package:memory_game/pages/game_result_page.dart';
import 'package:mocktail/mocktail.dart';

class GameBlocMock extends MockBloc<GameEvent, GameState> implements GameBloc {}

class GameStateFake extends Fake implements GameState {}

class GameEventFake extends Fake implements GameEvent {}

void main() {
  group('GameResultPage renders correctly when', () {
    setUpAll(() {
      registerFallbackValue(GameStateFake());
      registerFallbackValue(GameEventFake());
    });

    testWidgets(
      'user won game',
      (tester) async {
        final mockGameBloc = GameBlocMock();
        when(() => mockGameBloc.state).thenReturn(
          GameFinished(result: true), // the desired state
        );

        await tester.pumpWidget(BlocProvider<GameBloc>(
          create: (context) => mockGameBloc,
          child: const MaterialApp(
              home: Scaffold(
            body: GameResultPage(),
          )),
        ));

        await tester.pumpAndSettle();

        final youWonTextFinder = find.text('You Won'); // We should done this by key, this was just a way of
        // showcasing different ways of finding
        expect(youWonTextFinder, findsOneWidget);

        final youLoseTextFinder = find.text('You Lose');
        expect(youLoseTextFinder, findsNothing);
      },
    );

    testWidgets(
      'user lost game',
      (tester) async {
        final mockGameBloc = GameBlocMock();
        when(() => mockGameBloc.state).thenReturn(
          GameFinished(result: false), // the desired state
        );

        await tester.pumpWidget(BlocProvider<GameBloc>(
          create: (context) => mockGameBloc,
          child: const MaterialApp(
              home: Scaffold(
            body: GameResultPage(),
          )),
        ));

        await tester.pumpAndSettle();

        final youWonTextFinder = find.text('You Won'); // We should done this by key, this was just a way of
        // showcasing different ways of finding
        expect(youWonTextFinder, findsNothing);

        final youLoseTextFinder = find.text('You Lose');
        expect(youLoseTextFinder, findsOneWidget);
      },
    );
  });
}
