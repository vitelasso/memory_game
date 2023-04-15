import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_game/constants/constants.dart';
import 'package:memory_game/pages/home_page.dart';
import 'package:memory_game/utils/shared_prefs.dart';

import 'blocs/game_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: MaterialApp(
        title: Constants.strAppTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF1573AA),
            appBarTheme: const AppBarTheme(
              color: Color(0xFF142550),
            )),
        home: const HomePage(),
      ),
    );
  }
}
