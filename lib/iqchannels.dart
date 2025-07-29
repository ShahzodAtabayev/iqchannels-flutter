import 'iqchannels_platform_interface.dart';

class IQChannels {
  Future<void> configure({required String address, required String channel, String? style, String? language}) {
    return IqchannelsPlatform.instance.configure(address: address, channel: channel, style: style, language: language);
  }

  Future<void> setTheme({required String theme}) {
    return IqchannelsPlatform.instance.setTheme(theme: theme);
  }

  Future<void> setPushToken(String token, {bool isHuawei = false}) {
    return IqchannelsPlatform.instance.setPushToken(token, isHuawei: isHuawei);
  }

  Future<void> login(String token) {
    return IqchannelsPlatform.instance.login(token);
  }

  Future<void> logout() {
    return IqchannelsPlatform.instance.logout();
  }

  Future<void> loginAnonymous() {
    return IqchannelsPlatform.instance.loginAnonymous();
  }

  Future<void> logoutAnonymous() {
    return IqchannelsPlatform.instance.logoutAnonymous();
  }

  Future<void> openChat({String? styleJson, String? appbarTitle}) {
    return IqchannelsPlatform.instance.openChat(styleJson: styleJson, appbarTitle: appbarTitle);
  }
}
