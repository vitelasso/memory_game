import 'package:flutter_test/flutter_test.dart';
import 'package:memory_game/models/flip_card_model.dart';

void main() {
  test('flipcard model has correct values', () {
    // The model should be able to receive the following data:
    final user = FlipCard(id: 1, value: 1, isShow: false, isCompleted: false);

    expect(user.id, 1);
    expect(user.value, 1);
    expect(user.isShow, false);
    expect(user.isCompleted, false);
  });

  test('flipcard model returns to string correctly', () {
    // The model should be able to receive the following data:
    final user = FlipCard(id: 1, value: 1, isShow: false, isCompleted: false);

    expect(user.toString(), 'FlipCard{ id: 1, value: 1, isShow: false, isCompleted: false,}');
  });
}
