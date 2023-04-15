class FlipCard {
  int id;
  int value;
  bool isShow;
  bool isCompleted;

  FlipCard({
    required this.id,
    required this.value,
    required this.isShow,
    required this.isCompleted,
  });

  @override
  String toString() {
    return 'FlipCard{ id: $id, value: $value, isShow: $isShow, isCompleted: $isCompleted,}';
  }
}
