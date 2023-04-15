import 'package:flutter/material.dart';
import 'package:memory_game/models/flip_card_model.dart';
import 'package:memory_game/widgets/flip_card_widget.dart';

class GameBoardWidget extends StatelessWidget {
  final int numberOfColumns;
  final List<FlipCard> flipCards;
  const GameBoardWidget({Key? key, required this.numberOfColumns, required this.flipCards}) : super(key: key);

  @override
  Widget build(BuildContext context) => GridView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numberOfColumns,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        children: List.generate(
          flipCards.length,
          (index) => FlipCardWidget(flipCard: flipCards[index]),
        ),
      );
}
