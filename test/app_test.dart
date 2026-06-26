import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lift_it_up/app.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: LiftItUpApp()));
    await tester.pumpAndSettle();

    // Check if we are on the splash screen initially
    expect(find.text('LIFT it UP'), findsOneWidget);
  });
}
