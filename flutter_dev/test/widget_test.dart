
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_dev/main.dart';

void main() {
  testWidgets('Flutter Dev title', (WidgetTester tester) async {
    // Given
    await tester.pumpWidget(MyApp());

    // Then
    expect(find.text('Flutter Dev'), findsOneWidget);
  });
}
