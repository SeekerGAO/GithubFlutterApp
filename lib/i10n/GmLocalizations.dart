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
    return isZh ? "Github 应用" : "Github APP";
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
      GmLocalizations(locale.languageCode == 'zh');
    );
  }

  @override
  bool shouldReload(LocalizationsDelegate<GmLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

}