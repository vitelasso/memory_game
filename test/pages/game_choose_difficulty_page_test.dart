// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_game/blocs/game_bloc.dart';
import 'package:memory_game/pages/game_choose_difficulty_page.dart';
import 'package:memory_game/utils/game_difficulty.dart';

const difficulty4x4 = Key('radio_choose_difficultu_4x4');
const difficulty4x6 = Key('radio_choose_difficultu_4x6');
const difficulty5x6 = Key('radio_choose_difficultu_5x6');

final radio4x4Finder = find.byKey(const Key('difficulty4x4'));

Widget makeTestableWidget() {
  return BlocProvider<GameBloc>(
    create: (context) => GameBloc(),
    child: const MaterialApp(
        home: Scaffold(
      body: GameChooseDifficultyPage(),
    )),
  );
}

void main() {
  group('GameChooseDifficultyPage radio button selection when', () {
    testWidgets(
      '4x4 is selected',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget());
        final radioListTile4x4 = find.byKey(difficulty4x4);

        expect(radioListTile4x4, findsOneWidget);
        expect(find.byKey(difficulty4x6), findsOneWidget);
        expect(find.byKey(difficulty5x6), findsOneWidget);

        var radioList = tester.firstWidget<RadioListTile>(radioListTile4x4);
        expect(radioList.value, GameDifficulty.easy);
        expect(radioList.checked, true);
      },
    );

    testWidgets(
      '4x6 is selected',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget());
        final radioListTile4x4 = find.byKey(difficulty4x4);
        final radioListTile4x6 = find.byKey(difficulty4x6);
        final radioListTile5x6 = find.byKey(difficulty5x6);

        expect(radioListTile4x4, findsOneWidget);
        expect(radioListTile4x6, findsOneWidget);
        expect(radioListTile5x6, findsOneWidget);

        await tester.tap(radioListTile4x6);
        await tester.pump();

        var radioList4x4 = tester.firstWidget<RadioListTile>(radioListTile4x4);
        expect(radioList4x4.checked, false);

        var radioList4x6 = tester.firstWidget<RadioListTile>(radioListTile4x6);
        expect(radioList4x6.checked, true);

        var radioList5x6 = tester.firstWidget<RadioListTile>(radioListTile5x6);
        expect(radioList5x6.checked, false);
      },
    );

    testWidgets(
      '5x6 is selected',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget());
        final radioListTile4x4 = find.byKey(difficulty4x4);
        final radioListTile4x6 = find.byKey(difficulty4x6);
        final radioListTile5x6 = find.byKey(difficulty5x6);

        expect(radioListTile4x4, findsOneWidget);
        expect(radioListTile4x6, findsOneWidget);
        expect(radioListTile5x6, findsOneWidget);

        await tester.tap(radioListTile5x6);
        await tester.pump();

        var radioList4x4 = tester.firstWidget<RadioListTile>(radioListTile4x4);
        expect(radioList4x4.checked, false);

        var radioList4x6 = tester.firstWidget<RadioListTile>(radioListTile4x6);
        expect(radioList4x6.checked, false);

        var radioList5x6 = tester.firstWidget<RadioListTile>(radioListTile5x6);
        expect(radioList5x6.checked, true);
      },
    );
  });
}
