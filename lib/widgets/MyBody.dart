import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter_app/common/index.dart';
import 'package:github_flutter_app/i10n/GmLocalizations.dart';
import 'package:github_flutter_app/models/index.dart';
import 'package:provider/provider.dart';

class MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);

    if(!userModel.isLogin){
      // 用户未登录，显示登录按钮
      return Center(
        child: RaisedButton(
          child: Text(GmLocalizations.of(context).login),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    }else{
      //已登录，则展示项目列表
      return InfiniteListView<Repo>(
        onRetrieveData: (int page, List<Repo> items, bool refresh) async {
          var data = await Git(context).getRepos(
              refresh: refresh,
              queryParameters: {
                'page': page,
                'page_size': 20,
              }
          );
          //把请求到的新数据添加到items中
          items.addAll(data);
          // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
          return data.length == 20;
        } ,
        itemBuilder: (List list, int index, BuildContext ctx){
          // 项目信息列表项
          return RepoItem(list[index]);
        },
      );
    }
  }
}
