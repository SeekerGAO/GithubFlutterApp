import 'package:flutter/material.dart';
import 'package:github_flutter_app/i10n/GmLocalizations.dart';
import 'package:github_flutter_app/widgets/index.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: MyBody(),
      drawer: MyDrawer(),
    );
  }
}