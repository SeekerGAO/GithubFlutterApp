import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Locale资源类
class GmLocalizations{
  GmLocalizations(this.isZh);

  // 是否为中文
  bool isZh = false;

  static GmLocalizations of(BuildContext context){
    return Localizations.of<GmLocalizations>(context,GmLocalizations);
  }

  //Locale相关值，title为应用标题
  String get title{
    return isZh ? "Github客户端" : "Github APP";
  }

  String get home{
    return isZh ? "首页" : "Home";
  }

  String get login{
    return isZh ? "登录" : "Login";
  }

  String get noDescription{
    return isZh ? "无描述" : "noDescription";
  }

  String get theme{
    return isZh ? "主题" : "Theme";
  }

  String get language{
    return isZh ? "语言" : "Language";
  }

  String get logout{
    return isZh ? "登出" : "Logout";
  }

  String get logoutTip{
    return isZh ? "是否想要登出" : "Do you want to Logout?";
  }

  String get cancel{
    return isZh ? "取消" : "cancel";
  }

  String get yes{
    return isZh ? "确定" : "sure";
  }

  String get userName{
    return isZh ? "用户名" : "userName";
  }

  String get userNameOrEmail{
    return isZh ? "用户名或邮箱" : "userNameOrEmail";
  }

  String get userNameRequired{
    return isZh ? "请输入用户名" : "userNameRequired";
  }

  String get password{
    return isZh ? "密码" : "password";
  }

  String get passwordRequired{
    return isZh ? "请输入密码" : "passwordRequired";
  }

  String get userNameOrPasswordWrong{
    return isZh ? "用户名或密码错误" : "userNameOrPasswordWrong";
  }

}

/// 在Locale改变时加载新的Locale资源
class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations>{
  const GmLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en', 'zh'].contains(locale.languageCode);
  }

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<GmLocalizations> load(Locale locale) {
    // TODO: implement load
    return SynchronousFuture<GmLocalizations>(
      GmLocalizations(locale.languageCode == 'zh')
    );
  }

  @override
  bool shouldReload(LocalizationsDelegate<GmLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

}