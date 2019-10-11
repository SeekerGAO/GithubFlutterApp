import 'package:flutter/material.dart';
import 'package:github_flutter_app/routes/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/Global.dart';
import 'i10n/GmLocalizations.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( // MultiProvider 将主题、用户、语言三种状态绑定到了应用的根上，如此一来，任何路由中都可以通过Provider.of()来获取这些状态，也就是说这三种状态是全局共享的
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(builder: (BuildContext context,
          ThemeModel themeModel, LocaleModel localeModel, Widget widget) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: themeModel.theme,
          ),
          onGenerateTitle: (context) {
            return GmLocalizations.of(context).title;
          },
          home: HomeRoute(), // 应用的主页
          locale: localeModel.getLocale(),
          // 支持中文、美式英语
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('zh', 'CN'),
          ],
          localizationsDelegates: [
            // 本地化的代理类
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // 注册我们的Delegate
            GmLocalizationsDelegate(),
          ],
          localeResolutionCallback:
              (Locale _locale, Iterable<Locale> supportedLocales) {
            if (localeModel.getLocale() != null) {
              // 已选定语言，则不跟随系统语言
              return localeModel.getLocale();
            } else {
              Locale locale;
              //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
              //则默认使用美国英语
              if (supportedLocales.contains(_locale)) {
                locale = _locale;
              } else {
                locale = Locale('en', 'US');
              }
              return locale;
            }
          },
          // 注册命名路由表
          routes: <String, WidgetBuilder>{
            "login": (context) => LoginRoute()
          },
        );
      }),
    );
  }
}
