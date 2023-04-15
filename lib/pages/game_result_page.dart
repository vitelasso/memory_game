import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_game/blocs/game_bloc.dart';
import 'package:memory_game/constants/constants.dart';
import 'package:memory_game/pages/game_page.dart';
import 'package:memory_game/pages/home_page.dart';
import 'package:memory_game/utils/game_difficulty.dart';
import 'package:memory_game/widgets/game_result_message_widget.dart';

class GameResultPage extends StatelessWidget {
  const GameResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameFinished) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 25),
                  GameResultMessageWidget(
                    title: state.result ? Constants.strGameResultWonTitle : Constants.strGameResultLoseTitle,
                    subtitle: state.result ? Constants.strGameResultWonSubTitle : Constants.strGameResultLoseSubTitle,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => context
                                .read<GameBloc>()
                                .add(GameRestart(isRestart: true, gameDifficulty: GameDifficulty.easy)),
                            icon: const Icon(Icons.refresh),
                            label: const Text(Constants.strGameRestart),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green), // <-- Text
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => context
                                .read<GameBloc>()
                                .add(GameRestart(isRestart: false, gameDifficulty: GameDifficulty.easy)),
                            icon: const Icon(Icons.home),
                            label: const Text(Constants.strGameExit),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red), // <-- Text
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is Game) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GamePage(),
                  ));
            } else if (state is GameStop) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            }
            if (state is GameInitial) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GamePage(),
                  ));
            }
          },
        ),
      ),
    );
  }
}
