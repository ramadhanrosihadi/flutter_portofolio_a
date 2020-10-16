import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/view/comingsoon_view.dart';
import 'package:flutter_starter_b/common/view/slider_view.dart';
import 'package:flutter_starter_b/ui/dashboard/widgets/dashboard_top.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardTop(
          text: "",
        ),
        SliderViewPage(
          height: 200,
          assetPaths: [
            "https://www.socialmediaexaminer.com/wp-content/uploads/2018/03/facebook-mobile-live-streams-how-to-brand-1200.png",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTBNa6otGPhaGZrf8kB8QwGw-x6lHzAAH8nJg&usqp=CAU",
            "https://www.3playmedia.com/wp-content/uploads/rendered-23-1400x550.jpg",
            "https://www.baliprod.com/wp-content/uploads/2020/04/BALIPROD-LIVE-STREAMING-TECH-1.jpg",
            "https://www.pngitem.com/pimgs/m/53-535018_watchity-live-streaming-cartoon-hd-png-download.png",
          ],
          isFromUrl: true,
        ),
        Expanded(
            child: ComingSoonView(
          text: "Halaman Utama",
        )),
      ],
    );
  }
}
