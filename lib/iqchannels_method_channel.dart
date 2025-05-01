import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'iqchannels_platform_interface.dart';

/// An implementation of [IqchannelsPlatform] that uses method channels.
class MethodChannelIqchannels extends IqchannelsPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('iqchannels');

  @override
  Future<void> configure({required String address, required String channel}) async {
    await methodChannel.invokeMethod('configure', {
      'address': address,
      'channel': channel,
    });
  }

  @override
  Future<void> setPushToken(String token, {bool isHuawei = false}) async {
    await methodChannel.invokeMethod('setPushToken', {
      'token': token,
      'isHuawei': isHuawei,
    });
  }

  @override
  Future<void> login(String token) async {
    await methodChannel.invokeMethod('login', {'token': token});
  }

  @override
  Future<void> logout() async {
    await methodChannel.invokeMethod('logout');
  }

  @override
  Future<void> loginAnonymous() async {
    await methodChannel.invokeMethod('loginAnonymous');
  }

  @override
  Future<void> logoutAnonymous() async {
    await methodChannel.invokeMethod('logoutAnonymous');
  }

  @override
  Future<void> openChat() async {
    await methodChannel.invokeMethod('openChat');
  }
}
