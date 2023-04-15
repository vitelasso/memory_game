import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_game/constants/constants.dart';
import 'package:memory_game/pages/game_choose_difficulty_page.dart';
import 'package:memory_game/utils/game_theme.dart';
import 'package:memory_game/utils/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 25),
              Text(Constants.strAppTitle,
                  key: const Key('home_page_app_title'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, fontSize: 30)),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        key: const Key('home_page_start_game_btn'),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameChooseDifficultyPage(),
                            )),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text(Constants.strGameStart), // <-- Text
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        key: const Key('home_page_theme_selection_btn'),
                        onPressed: () {
                          //since Pokemon is initially selected, we set once we open
                          // the dialog
                          showDialog(
                            context: context,
                            barrierDismissible: false, // Disable clicking outside after opening dialog
                            builder: (BuildContext context) {
                              String selectedTheme = GameTheme.pokemon.prefsKey;
                              return AlertDialog(
                                key: const Key('home_page_theme_selection_dialog'),
                                title: const Text(Constants.strSelectFavoriteTheme),
                                actions: [
                                  TextButton(
                                    child: const Text(Constants.strCommonOk),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                ],
                                content: StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return Column(mainAxisSize: MainAxisSize.min, children: [
                                      for (var value in GameTheme.values)
                                        ListTile(
                                          title: Text(value.title),
                                          trailing: SvgPicture.asset(
                                            "assets/themes/${value.prefsKey}.svg",
                                            width: 50,
                                            height: 50,
                                          ),
                                          leading: Radio(
                                            value: value.prefsKey,
                                            groupValue: selectedTheme,
                                            onChanged: (value) async {
                                              setState(() => selectedTheme = value!);
                                              SharedPrefs().selectedTheme = value!;
                                              //await prefs.setString(Constants.keySelectedTheme, value!);
                                            },
                                          ),
                                        ),
                                    ]);
                                  },
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.settings),
                        label: const Text(Constants.strThemeSelection), // <-- Text
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
