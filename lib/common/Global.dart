import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_flutter_app/models/cacheConfig.dart';
import 'package:github_flutter_app/models/profile.dart';
import 'package:github_flutter_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NetCache.dart';
import 'index.dart';

/// 创建五套主题
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.green,
  Colors.teal,
  Colors.orange,
  Colors.grey
];

/// 全局变量
class Global {
  static SharedPreferences _prefs;

  static Profile profile = Profile();

  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息，在app启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("proflie");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    //初始化网络请求相关配置
    Git.init();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}

/// 更新Profile信息并进行持久化
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners

    Global.saveProfile(); //保存Profile变更

    super.notifyListeners(); //通知依赖的Widget更新
  }
}

/// 用户状态
class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

/// APP主题状态
class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.blue);

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(ColorSwatch colorSwatch) {
    if (colorSwatch != theme) {
      _profile.theme = colorSwatch[500].value;
      notifyListeners();
    }
  }
}

/// APP语言状态
class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  // 获取当前Locale的字符串表示
  String get locale => _profile.locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
