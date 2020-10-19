import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_b/common/constant/VTheme.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';

class ScaffoldDefault extends StatelessWidget {
  const ScaffoldDefault({Key key, this.textTitle, this.backgroundColor = Colors.white, this.body, this.floatingActionButton}) : super(key: key);

  final String textTitle;
  final Color backgroundColor;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: textTitle != null ? Fun.defaultAppBar(textTitle) : null,
        body: Theme(
          data: VTheme.defaultForm(context),
          child: body,
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
