enum GameTheme {
  pokemon,
  starWars,
  peppaPig,
}

extension GameThemeExtension on GameTheme {
  String get title {
    switch (this) {
      case GameTheme.pokemon:
        return "Pokemon";
      case GameTheme.starWars:
        return "Star Wars";
      case GameTheme.peppaPig:
      default:
        return "Peppa Pig";
    }
  }

  String get prefsKey {
    switch (this) {
      case GameTheme.pokemon:
        return "pokemon";
      case GameTheme.starWars:
        return "star_wars";
      case GameTheme.peppaPig:
      default:
        return "peppa";
    }
  }
}
