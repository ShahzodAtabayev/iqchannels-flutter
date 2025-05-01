import 'package:flutter_test/flutter_test.dart';
import 'package:iqchannels/iqchannels.dart';
import 'package:iqchannels/iqchannels_platform_interface.dart';
import 'package:iqchannels/iqchannels_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIqchannelsPlatform with MockPlatformInterfaceMixin implements IqchannelsPlatform {
  bool configureCalled = false;
  String? configureAddress;
  String? configureChannel;

  bool loginCalled = false;
  String? loginToken;

  bool logoutCalled = false;
  bool loginAnonymousCalled = false;
  bool logoutAnonymousCalled = false;
  bool openChatCalled = false;

  bool setPushTokenCalled = false;
  String? setPushTokenValue;
  bool? setPushTokenIsHuawei;

  @override
  Future<void> configure({required String address, required String channel}) async {
    configureCalled = true;
    configureAddress = address;
    configureChannel = channel;
  }

  @override
  Future<void> login(String token) async {
    loginCalled = true;
    loginToken = token;
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }

  @override
  Future<void> loginAnonymous() async {
    loginAnonymousCalled = true;
  }

  @override
  Future<void> logoutAnonymous() async {
    logoutAnonymousCalled = true;
  }

  @override
  Future<void> openChat() async {
    openChatCalled = true;
  }

  @override
  Future<void> setPushToken(String token, {bool isHuawei = false}) async {
    setPushTokenCalled = true;
    setPushTokenValue = token;
    setPushTokenIsHuawei = isHuawei;
  }
}

void main() {
  final IqchannelsPlatform initialPlatform = IqchannelsPlatform.instance;

  test('$MethodChannelIqchannels is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIqchannels>());
  });

  test('configure calls platform instance', () async {
    final plugin = IQChannels();
    final mockPlatform = MockIqchannelsPlatform();
    IqchannelsPlatform.instance = mockPlatform;

    await plugin.configure(address: 'https://test.com', channel: 'support');

    expect(mockPlatform.configureCalled, isTrue);
    expect(mockPlatform.configureAddress, 'https://test.com');
    expect(mockPlatform.configureChannel, 'support');
  });

  test('setPushToken calls platform instance with correct values', () async {
    final plugin = IQChannels();
    final mockPlatform = MockIqchannelsPlatform();
    IqchannelsPlatform.instance = mockPlatform;

    await plugin.setPushToken('push-token-123', isHuawei: true);

    expect(mockPlatform.setPushTokenCalled, isTrue);
    expect(mockPlatform.setPushTokenValue, 'push-token-123');
    expect(mockPlatform.setPushTokenIsHuawei, isTrue);
  });

  test('login calls platform instance', () async {
    final plugin = IQChannels();
    final mockPlatform = MockIqchannelsPlatform();
    IqchannelsPlatform.instance = mockPlatform;

    await plugin.login('token123');

    expect(mockPlatform.loginCalled, isTrue);
    expect(mockPlatform.loginToken, 'token123');
  });

  test('logout calls platform instance', () async {
    final plugin = IQChannels();
    final mockPlatform = MockIqchannelsPlatform();
    IqchannelsPlatform.instance = mockPlatform;

    await plugin.logout();

    expect(mockPlatform.logoutCalled, isTrue);
  });

  test('loginAnonymous calls platform instance', () async {
    final plugin = IQChannels();
    final mockPlatform = MockIqchannelsPlatform();
    IqchannelsPlatform.instance = mockPlatform;

    await plugin.loginAnonymous();

    expect(mockPlatform.loginAnonymousCalled, isTrue);
  });

  test('logoutAnonymous calls platform instance', () async {
    final plugin = IQChannels();
    final mockPlatform = MockIqchannelsPlatform();
    IqchannelsPlatform.instance = mockPlatform;

    await plugin.logoutAnonymous();

    expect(mockPlatform.logoutAnonymousCalled, isTrue);
  });

  test('openChat calls platform instance', () async {
    final plugin = IQChannels();
    final mockPlatform = MockIqchannelsPlatform();
    IqchannelsPlatform.instance = mockPlatform;

    await plugin.openChat();

    expect(mockPlatform.openChatCalled, isTrue);
  });
}
