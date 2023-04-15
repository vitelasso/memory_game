import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:memory_game/blocs/game_bloc.dart';
import 'package:memory_game/constants/constants.dart';
import 'package:memory_game/pages/game_result_page.dart';
import 'package:memory_game/utils/game_difficulty.dart';
import 'package:memory_game/widgets/game_board_widget_dart.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late CountdownTimerController _controller;

  @override
  void initState() {
    _controller = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 1000 * Constants.intGameTimeOutSeconds,
      onEnd: () => context.read<GameBloc>().add(GameTimeOut()),
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //disable back button from leaving the game
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocConsumer<GameBloc, GameState>(listener: (context, state) {
          if (state is GameFinished) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameResultPage(),
                ));
          }
        }, builder: (context, state) {
          if (state is Game) {
            return Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SafeArea(
                          child: CountdownTimer(
                            controller: _controller,
                            widgetBuilder: (context, time) => Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  time!.sec.toString(),
                                  style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GameBoardWidget(
                              numberOfColumns: state.gameDifficulty.numberOfColumns,
                              flipCards: state.cards,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                      child: Text(
                                        '${Constants.strGameMovesTitle}: ${state.moveCounts}',
                                        key: const Key('game_page_moves_text'),
                                        style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                      child: Text(
                                        '${Constants.strGameRemainingPairs}: ${state.remainingPairs}',
                                        key: const Key('game_page_remaining_pairs_text'),
                                        style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    // You can add title here
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor: Colors.white.withOpacity(0), //You can make this transparent
                    elevation: 0.0, //No shadow
                  ),
                ),
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
