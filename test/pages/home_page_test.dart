import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_game/pages/home_page.dart';

const appTitleTestKey = Key('home_page_app_title');
const buttonStartGame = Key('home_page_start_game_btn');
const buttonThemeSelection = Key('home_page_theme_selection_btn');
const dialogThemeSelection = Key('home_page_theme_selection_dialog');

void main() {
  group('HomePage renders correct widgets when', () {
    testWidgets(
      'no theme selection dialog',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: HomePage()));

        expect(find.byKey(appTitleTestKey), findsOneWidget);
        expect(find.byKey(buttonStartGame), findsOneWidget);
        expect(find.byKey(buttonThemeSelection), findsOneWidget);
      },
    );

    testWidgets(
      'with theme selection dialog',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: HomePage()));

        final button = find.byKey(buttonThemeSelection);
        await tester.ensureVisible(button);

        await tester.tap(button);

        await tester.pumpAndSettle();

        expect(find.byKey(dialogThemeSelection), findsOneWidget);
      },
    );
  });
}
