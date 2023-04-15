import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_game/blocs/game_bloc.dart';
import 'package:memory_game/models/flip_card_model.dart';
import 'package:memory_game/utils/game_difficulty.dart';

class GameBlocMock extends MockBloc<GameEvent, GameState> implements GameBloc {}

class GameStateFake extends Fake implements GameState {}

class GameEventFake extends Fake implements GameEvent {}

List<FlipCard> mockFlipCardsInitial({bool allCompleted = false}) => [
      FlipCard(id: 1, value: 1, isShow: !allCompleted, isCompleted: !allCompleted),
      FlipCard(id: 2, value: 2, isShow: allCompleted, isCompleted: allCompleted),
      FlipCard(id: 3, value: 1, isShow: allCompleted, isCompleted: !allCompleted),
      FlipCard(id: 4, value: 2, isShow: allCompleted, isCompleted: allCompleted),
    ];

void main() {
  group('CounterBloc', () {
    blocTest('emits [Game] when GameStart Event added',
        build: () => GameBloc(),
        act: (bloc) => bloc.add(GameStart(gameDifficulty: GameDifficulty.medium)),
        expect: () => [isA<Game>()]);

    blocTest('emits [GameFinished] when GameTimeOut Event added',
        build: () => GameBloc(), act: (bloc) => bloc.add(GameTimeOut()), expect: () => [isA<GameFinished>()]);

    blocTest('emits [Game] when GameFinished Event added with possibility to restart',
        build: () => GameBloc(),
        seed: () => GameFinished(result: true) as GameState,
        act: (bloc) => bloc.add(GameRestart(isRestart: true, gameDifficulty: GameDifficulty.easy)),
        expect: () => [isA<Game>()]);

    blocTest('emits [Game] when GameChange Event added and still remaining cards to open',
        build: () => GameBloc(),
        wait: const Duration(milliseconds: 1000),
        seed: () =>
            Game(gameDifficulty: GameDifficulty.easy, cards: mockFlipCardsInitial(), moveCounts: 8, remainingPairs: 8)
                as GameState,
        act: (bloc) => bloc.add(GameChange(card: FlipCard(id: 1, value: 0, isShow: false, isCompleted: false))),
        expect: () => [isA<Game>()]);

    blocTest('emits [Game] when GameChange Event added and still remaining cards to open',
        build: () => GameBloc(),
        wait: const Duration(milliseconds: 1000),
        seed: () =>
            Game(gameDifficulty: GameDifficulty.easy, cards: mockFlipCardsInitial(), moveCounts: 8, remainingPairs: 8)
                as GameState,
        act: (bloc) => bloc.add(GameChange(card: FlipCard(id: 1, value: 0, isShow: false, isCompleted: false))),
        expect: () => [isA<Game>()]);

    blocTest('emits [Game, Game, GameFinished ] when GameChange Event added and no more remaining cards to open',
        build: () => GameBloc(),
        wait: const Duration(milliseconds: 2000),
        seed: () => Game(
            gameDifficulty: GameDifficulty.easy,
            cards: mockFlipCardsInitial(allCompleted: true),
            moveCounts: 8,
            remainingPairs: 8) as GameState,
        act: (bloc) => bloc.add(GameChange(card: FlipCard(id: 1, value: 1, isShow: false, isCompleted: false))),
        expect: () => [isA<Game>(), isA<Game>(), isA<GameFinished>()]);
  });
}
