part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameStop extends GameState {}

class Game extends GameState {
  final GameDifficulty gameDifficulty;
  final List<FlipCard> cards;
  final int moveCounts;
  final int remainingPairs;
  Game({
    required this.gameDifficulty,
    required this.cards,
    required this.moveCounts,
    required this.remainingPairs,
  });
}

class GameFinished extends GameState {
  final bool result;
  GameFinished({required this.result});
}
