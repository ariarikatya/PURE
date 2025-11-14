import 'package:flutter_test/flutter_test.dart';

import 'package:pure/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PureApp());

    // Verify that the app loads successfully
    expect(find.text('ЧАТЫ'), findsOneWidget);
  });
}
