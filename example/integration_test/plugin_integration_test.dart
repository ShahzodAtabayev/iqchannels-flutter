import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:iqchannels/iqchannels.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final plugin = IQChannels();

  testWidgets('configure completes without exception', (WidgetTester tester) async {
    await plugin.configure(
      address: 'https://your.domain.com',
      channel: 'channel',
    );
    // If no exception is thrown, test passed
    expect(true, isTrue);
  });

  testWidgets('setPushToken completes without exception', (WidgetTester tester) async {
    await plugin.setPushToken('dummy-token');
    expect(true, isTrue);
  });

  testWidgets('login completes without exception', (WidgetTester tester) async {
    await plugin.login('your-auth-token');
    expect(true, isTrue);
  });

  testWidgets('logout completes without exception', (WidgetTester tester) async {
    await plugin.logout();
    expect(true, isTrue);
  });

  testWidgets('loginAnonymous completes without exception', (WidgetTester tester) async {
    await plugin.loginAnonymous();
    expect(true, isTrue);
  });

  testWidgets('logoutAnonymous completes without exception', (WidgetTester tester) async {
    await plugin.logoutAnonymous();
    expect(true, isTrue);
  });

  testWidgets('openChat completes without exception', (WidgetTester tester) async {
    await plugin.openChat();
    expect(true, isTrue);
  });
}
