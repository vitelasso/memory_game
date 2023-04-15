import 'package:memory_game/constants/constants.dart';
import 'package:memory_game/utils/game_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

//utility class for getting a SharedPreferences instance without having to always get asynchronous in every class
class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    String? selectedThemeValue = _sharedPrefs.getString(Constants.keySelectedTheme);
    if (selectedThemeValue == null) selectedTheme = GameTheme.pokemon.prefsKey;
  }

  String get selectedTheme => _sharedPrefs.getString(Constants.keySelectedTheme) ?? "";

  set selectedTheme(String value) {
    _sharedPrefs.setString(Constants.keySelectedTheme, value);
  }
}
