import 'package:flutter/material.dart';
import 'package:github_flutter_app/common/index.dart';
import 'package:github_flutter_app/i10n/GmLocalizations.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).theme),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
              child: Container(
                  color: e,
                  height: 40,
              ),
            ),
            onTap: () {
              //主题更新后，MaterialApp会重新build
              Provider.of<ThemeModel>(context).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}
