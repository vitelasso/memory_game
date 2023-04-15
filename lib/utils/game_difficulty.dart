enum GameDifficulty {
  easy,
  medium,
  difficult,
}

extension GameDifficultyExtension on GameDifficulty {
  String get title {
    switch (this) {
      case GameDifficulty.medium:
        return "4x6";
      case GameDifficulty.difficult:
        return "5x6";
      case GameDifficulty.easy:
      default:
        return "4x4";
    }
  }

  int get numberOfFlipCards {
    switch (this) {
      case GameDifficulty.medium:
        return 4 * 6;
      case GameDifficulty.difficult:
        return 5 * 6;
      case GameDifficulty.easy:
      default:
        return 4 * 4;
    }
  }

  int get numberOfColumns {
    switch (this) {
      case GameDifficulty.difficult:
        return 5;
      case GameDifficulty.easy:
      case GameDifficulty.medium:
      default:
        return 4;
    }
  }
}
