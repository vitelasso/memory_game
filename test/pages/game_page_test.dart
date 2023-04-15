import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_game/blocs/game_bloc.dart';
import 'package:memory_game/models/flip_card_model.dart';
import 'package:memory_game/pages/game_page.dart';
import 'package:memory_game/utils/game_difficulty.dart';
import 'package:memory_game/utils/shared_prefs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameBlocMock extends MockBloc<GameEvent, GameState> implements GameBloc {}

class GameStateFake extends Fake implements GameState {}

class GameEventFake extends Fake implements GameEvent {}

List<FlipCard> mockFlipCardsInitial = [
  FlipCard(id: 1, value: 1, isShow: false, isCompleted: false),
  FlipCard(id: 2, value: 2, isShow: false, isCompleted: false),
  FlipCard(id: 3, value: 1, isShow: false, isCompleted: false),
  FlipCard(id: 4, value: 2, isShow: false, isCompleted: false),
];

List<FlipCard> mockFlipCardsMatched = [
  FlipCard(id: 1, value: 1, isShow: true, isCompleted: true),
  FlipCard(id: 2, value: 2, isShow: false, isCompleted: false),
  FlipCard(id: 3, value: 1, isShow: true, isCompleted: true),
  FlipCard(id: 4, value: 2, isShow: false, isCompleted: false),
];

void main() {
  group('GamePage renders correctly when', () {
    setUpAll(() {
      registerFallbackValue(GameStateFake());
      registerFallbackValue(GameEventFake());
    });

    testWidgets(
      'user start game with the correct amount of cards',
      (tester) async {
        final mockGameBloc = GameBlocMock();
        when(() => mockGameBloc.state).thenReturn(
          Game(
              gameDifficulty: GameDifficulty.easy,
              cards: mockFlipCardsInitial,
              moveCounts: 0,
              remainingPairs: (mockFlipCardsInitial.length / 2).round()), // the desired state
        );
        SharedPreferences.setMockInitialValues({});
        await SharedPrefs().init();

        await tester.pumpWidget(BlocProvider<GameBloc>(
          create: (context) => mockGameBloc,
          child: const MaterialApp(
              home: Scaffold(
            body: GamePage(),
          )),
        ));

        await tester.pumpAndSettle();

        //find amount of flip cards
        expect(find.byType(Card), findsNWidgets(mockFlipCardsInitial.length));

        //find Moves text
        expect(find.byKey(const Key('game_page_moves_text')), findsOneWidget);
        //getting Text object
        Text movesText = tester.firstWidget(find.byKey(const Key('game_page_moves_text')));
        expect(movesText.data, 'Moves: 0'); //this might change when we introduced localization

        //find Moves text
        expect(find.byKey(const Key('game_page_remaining_pairs_text')), findsOneWidget);
        //getting Text object
        Text remainingPairsText = tester.firstWidget(find.byKey(const Key('game_page_remaining_pairs_text')));
        expect(remainingPairsText.data,
            'Remaining Pairs: ${(mockFlipCardsInitial.length / 2).round()}'); //this might change when we introduced localization
      },
    );

    testWidgets(
      'user encounter matching pair',
      (tester) async {
        final mockGameBloc = GameBlocMock();
        when(() => mockGameBloc.state).thenReturn(
          Game(
              gameDifficulty: GameDifficulty.easy,
              cards: mockFlipCardsMatched,
              moveCounts: 2,
              remainingPairs: (mockFlipCardsMatched.length / 2).round() - 1), // the desired state
        );
        SharedPreferences.setMockInitialValues({});
        await SharedPrefs().init();

        await tester.pumpWidget(BlocProvider<GameBloc>(
          create: (context) => mockGameBloc,
          child: const MaterialApp(
              home: Scaffold(
            body: GamePage(),
          )),
        ));

        await tester.pumpAndSettle();

        //find amount of flip cards
        expect(find.byType(Card), findsNWidgets(mockFlipCardsInitial.length));

        //find Moves text
        expect(find.byKey(const Key('game_page_moves_text')), findsOneWidget);
        //getting Text object
        Text movesText = tester.firstWidget(find.byKey(const Key('game_page_moves_text')));
        expect(movesText.data, 'Moves: 2'); //this might change when we introduced localization

        //find Moves text
        expect(find.byKey(const Key('game_page_remaining_pairs_text')), findsOneWidget);
        //getting Text object
        Text remainingPairsText = tester.firstWidget(find.byKey(const Key('game_page_remaining_pairs_text')));
        expect(remainingPairsText.data,
            'Remaining Pairs: ${(mockFlipCardsInitial.length / 2).round() - 1}'); //this might change when we introduced
        // localization
      },
    );
  });
}
