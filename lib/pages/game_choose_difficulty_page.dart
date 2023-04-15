import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_game/blocs/game_bloc.dart';
import 'package:memory_game/constants/constants.dart';
import 'package:memory_game/pages/game_page.dart';
import 'package:memory_game/utils/game_difficulty.dart';

class GameChooseDifficultyPage extends StatefulWidget {
  const GameChooseDifficultyPage({Key? key}) : super(key: key);

  @override
  State<GameChooseDifficultyPage> createState() => _GameChooseDifficultyPageState();
}

class _GameChooseDifficultyPageState extends State<GameChooseDifficultyPage> {
  GameDifficulty _defaultDifficulty = GameDifficulty.easy;
  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is Game) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GamePage(),
              ));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 25),
              Text(Constants.strDifficultySelection,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, fontSize: 30)),
              Column(
                children: [
                  for (var value in GameDifficulty.values)
                    RadioListTile(
                      key: Key('radio_choose_difficultu_${value.title}'),
                      title: Text(value.title),
                      value: value,
                      groupValue: _defaultDifficulty,
                      onChanged: (value) {
                        setState(() {
                          _defaultDifficulty = value as GameDifficulty;
                        });
                      },
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.read<GameBloc>().add(GameStart(gameDifficulty: _defaultDifficulty)),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(Constants.strGameStart), // <-- Text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
