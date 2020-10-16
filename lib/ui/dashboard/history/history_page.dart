import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/view/comingsoon_view.dart';
import 'package:flutter_starter_b/ui/dashboard/widgets/dashboard_top.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardTop(
          text: "History",
        ),
        Expanded(
            child: ComingSoonView(
          text: "History",
        )),
      ],
    );
  }
}
