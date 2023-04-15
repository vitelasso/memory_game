import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:memory_game/models/flip_card_model.dart';
import 'package:memory_game/utils/game_difficulty.dart';
import 'package:memory_game/utils/utils.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GameStart>((event, emit) => emit(Game(
        gameDifficulty: event.gameDifficulty,
        cards: generateCards(numOfCards: event.gameDifficulty.numberOfFlipCards),
        moveCounts: 0,
        remainingPairs: (event.gameDifficulty.numberOfFlipCards / 2).round())));

    on<GameTimeOut>((event, emit) => emit(GameFinished(result: false)));

    on<GameRestart>((event, emit) {
      if (state is GameFinished) {
        if (event.isRestart) {
          emit(Game(
              gameDifficulty: event.gameDifficulty,
              cards: generateCards(numOfCards: event.gameDifficulty.numberOfFlipCards),
              moveCounts: 0,
              remainingPairs: (event.gameDifficulty.numberOfFlipCards / 2).round()));
        } else {
          emit(GameStop());
        }
      }
    });

    on<GameChange>((event, emit) async {
      final state = this.state;

      if (state is Game) {
        event.card.isShow = true;
        List<FlipCard> cards = state.cards.map((e) => e.id == event.card.id ? event.card : e).toList();
        emit(Game(
            gameDifficulty: state.gameDifficulty,
            cards: cards,
            moveCounts: state.moveCounts,
            remainingPairs: state.remainingPairs));

        List<FlipCard> temp = cards.where((card) => card.isShow && !card.isCompleted).toList();

        await Future.delayed(const Duration(milliseconds: 250));

        if (temp.length == 2) {
          if (temp.first.value == temp.last.value) {
            temp.first.isCompleted = true;
            temp.last.isCompleted = true;
          } else {
            temp.first.isShow = false;
            temp.last.isShow = false;
          }
          cards = state.cards
              .map((e) => e.id == temp.first.id
                  ? temp.first
                  : e.id == temp.last.id
                      ? temp.last
                      : e)
              .toList();
          int remainingPairs = ((cards.where((element) => !element.isCompleted).length) / 2).round();
          emit(Game(
              gameDifficulty: state.gameDifficulty,
              cards: cards,
              moveCounts: state.moveCounts + 1,
              remainingPairs: remainingPairs));
          await Future.delayed(const Duration(milliseconds: 500));

          if (remainingPairs == 0) emit(GameFinished(result: true));
        }
      }
    });
  }
}
