part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameStart extends GameEvent {
  final GameDifficulty gameDifficulty;
  GameStart({required this.gameDifficulty});
}

class GameChange extends GameEvent {
  final FlipCard card;
  GameChange({required this.card});
}

class GameTimeOut extends GameEvent {}

class GameRestart extends GameEvent {
  final GameDifficulty gameDifficulty;
  final bool isRestart;
  GameRestart({required this.isRestart, required this.gameDifficulty});
}
