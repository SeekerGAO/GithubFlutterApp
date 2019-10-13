import 'package:flutter/material.dart';
import 'package:github_flutter_app/common/index.dart';
import 'package:github_flutter_app/i10n/GmLocalizations.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem(gm.auto, null),
        ],
      ),
    );
  }
}

Widget _buildLanguageItem(String lang, value) {
  return Consumer<LocaleModel>(
    builder: (BuildContext context, LocaleModel localeModel, Widget widget) {
      var color = Theme.of(context).primaryColor;

      return ListTile(
        title: Text(lang,
            style:
                TextStyle(color: localeModel.locale == value ? color : null)),
        trailing: localeModel.locale == value
            ? Icon(
                Icons.done,
                color: color,
              )
            : null,
        onTap: () {
          // 更新locale后MaterialApp会重新build
          localeModel.locale = value;
        },
      );
    },
  );
}
