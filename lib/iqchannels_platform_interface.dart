import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'iqchannels_method_channel.dart';

abstract class IqchannelsPlatform extends PlatformInterface {
  IqchannelsPlatform() : super(token: _token);

  static final Object _token = Object();

  static IqchannelsPlatform _instance = MethodChannelIqchannels();

  static IqchannelsPlatform get instance => _instance;

  static set instance(IqchannelsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> configure({required String address, required String channel}) {
    throw UnimplementedError('configure() has not been implemented.');
  }

  Future<void> setPushToken(String token, {bool isHuawei = false}) {
    throw UnimplementedError('setPushToken() has not been implemented.');
  }

  Future<void> login(String token) {
    throw UnimplementedError('login() has not been implemented.');
  }

  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }

  Future<void> loginAnonymous() {
    throw UnimplementedError('loginAnonymous() has not been implemented.');
  }

  Future<void> logoutAnonymous() {
    throw UnimplementedError('logoutAnonymous() has not been implemented.');
  }

  Future<void> openChat({String? styleJson, String? appbarTitle}) {
    throw UnimplementedError('openChat() has not been implemented.');
  }
}
