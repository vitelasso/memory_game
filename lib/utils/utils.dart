import 'package:memory_game/models/flip_card_model.dart';

List<FlipCard> generateCards({int numOfCards = 30}) {
  List<FlipCard> cards = [];
  int value = 1;
  for (int i = 1; i <= numOfCards; i++) {
    cards.add(FlipCard(id: i, value: value, isShow: false, isCompleted: false));
    if (i % 2 == 0) value++;
  }
  cards.shuffle();
  return cards;
}
