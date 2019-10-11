import 'package:flutter/material.dart';

/// 自定义Icon类
/// 使用iconfont字体
/// 查看iconfont.css，将 \替换成0x即可得到对应的 codePoint
//.icon-qq-copy:before {
//  content: "\e67f";
//}
class MyIcon {
  // qq图标
  static const IconData qq = const IconData(
      0xe63c,
      fontFamily: 'myIcon',
      matchTextDirection: true
  );

  // 微信图标
  static const IconData we_chat = const IconData(
      0xe67f,
      fontFamily: 'myIcon',
      matchTextDirection: true
  );

  // github仓库fork
  static const IconData fork = const IconData(
      0xe7e8,
      fontFamily: 'myIcon',
      matchTextDirection: true
  );
}