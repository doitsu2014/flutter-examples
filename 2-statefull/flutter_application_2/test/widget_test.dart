import 'package:flutter_application_2/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// Reads the value rendered by the counter through its declared contract key
/// (`ValueKey('counter-value')`) instead of matching the digits as free text.
String counterText(WidgetTester tester) =>
    tester.widget<Text>(find.byKey(const ValueKey('counter-value'))).data!;

void main() {
  testWidgets('starts at zero', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    expect(counterText(tester), '0');
  });

  testWidgets('increment updates the displayed value', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();

    expect(counterText(tester), '1');
  });

  testWidgets('decrement steps the displayed value down', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();
    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();

    await tester.tap(find.byTooltip('Decrement'));
    await tester.pump();

    expect(counterText(tester), '1');
  });

  testWidgets('never goes below zero', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.byTooltip('Decrement'));
    await tester.pump();

    expect(counterText(tester), '0');
    expect(find.text('-1'), findsNothing);
  });

  testWidgets('reset returns the counter to zero', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();
    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();

    await tester.tap(find.byTooltip('Reset'));
    await tester.pump();

    expect(counterText(tester), '0');
  });
}
