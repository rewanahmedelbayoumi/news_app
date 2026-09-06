import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/main.dart';
import 'package:news_app/services/auth_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('News App loads successfully', (WidgetTester tester) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final authService = AuthService();

    await tester.pumpWidget(
      NewsApp(
        authService: authService,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('News'), findsOneWidget);
    expect(find.text('Featured News'), findsOneWidget);
    expect(find.text('Latest News'), findsOneWidget);

    authService.dispose();
  });
}