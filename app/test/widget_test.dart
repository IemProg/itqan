import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/app.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ItqanApp());
    expect(find.text('السلام عليكم'), findsWidgets);
  });
}
