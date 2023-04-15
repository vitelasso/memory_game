import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_game/blocs/game_bloc.dart';
import 'package:memory_game/models/flip_card_model.dart';
import 'package:memory_game/utils/shared_prefs.dart';

class FlipCardWidget extends StatelessWidget {
  final FlipCard flipCard;
  const FlipCardWidget({Key? key, required this.flipCard}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        color: flipCard.isCompleted ? Colors.amber : null,
        shape: flipCard.isCompleted ? const StarBorder() : null,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 3,
        child: InkWell(
          onTap: flipCard.isCompleted || flipCard.isShow
              ? null
              : () => context.read<GameBloc>().add(GameChange(card: flipCard)),
          child: Center(
            child: flipCard.isShow
                ? Text(
                    flipCard.value.toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : SvgPicture.asset("assets/themes/${SharedPrefs().selectedTheme}.svg"),
          ),
        ),
      );
}
