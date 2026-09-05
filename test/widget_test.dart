import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/main.dart';

void main() {
  testWidgets('News App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsApp());

    expect(find.text('News'), findsOneWidget);
    expect(find.text('Featured News'), findsOneWidget);
    expect(find.text('Latest News'), findsOneWidget);
  });
}