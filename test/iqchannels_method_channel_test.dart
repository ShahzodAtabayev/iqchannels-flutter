import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iqchannels/iqchannels_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelIqchannels platform = MethodChannelIqchannels();
  const MethodChannel channel = MethodChannel('iqchannels');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        // Return something dummy for testing
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('configure sends correct arguments', () async {
    bool called = false;
    Map<String, dynamic>? passedArgs;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (methodCall) async {
        if (methodCall.method == 'configure') {
          called = true;
          passedArgs = Map<String, dynamic>.from(methodCall.arguments);
        }
        return null;
      },
    );

    await platform.configure(address: 'https://test.com', channel: 'support');

    expect(called, isTrue);
    expect(passedArgs?['address'], 'https://test.com');
    expect(passedArgs?['channel'], 'support');
  });

  test('login calls native method', () async {
    bool called = false;
    String? tokenPassed;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (methodCall) async {
        if (methodCall.method == 'login') {
          called = true;
          tokenPassed = methodCall.arguments['token'];
        }
        return null;
      },
    );

    await platform.login('abc123');

    expect(called, isTrue);
    expect(tokenPassed, 'abc123');
  });

  test('logout calls native method', () async {
    bool called = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (methodCall) async {
        if (methodCall.method == 'logout') {
          called = true;
        }
        return null;
      },
    );

    await platform.logout();

    expect(called, isTrue);
  });

  test('loginAnonymous calls native method', () async {
    bool called = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (methodCall) async {
        if (methodCall.method == 'loginAnonymous') {
          called = true;
        }
        return null;
      },
    );

    await platform.loginAnonymous();

    expect(called, isTrue);
  });

  test('logoutAnonymous calls native method', () async {
    bool called = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (methodCall) async {
        if (methodCall.method == 'logoutAnonymous') {
          called = true;
        }
        return null;
      },
    );

    await platform.logoutAnonymous();

    expect(called, isTrue);
  });

  test('openChat calls native method', () async {
    bool called = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (methodCall) async {
        if (methodCall.method == 'openChat') {
          called = true;
        }
        return null;
      },
    );

    await platform.openChat();

    expect(called, isTrue);
  });
}
