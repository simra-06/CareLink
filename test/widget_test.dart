import 'package:flutter_test/flutter_test.dart';
import 'package:chatbot_app/main.dart';

void main() {
  testWidgets('App loads and shows welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome to Flutter!'), findsOneWidget);
    expect(find.text('Your project scaffold is ready.'), findsOneWidget);
  });
}
