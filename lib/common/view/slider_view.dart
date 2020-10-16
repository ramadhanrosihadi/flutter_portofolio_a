import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/widget/cached_image.dart';

class SliderViewPage extends StatefulWidget {
  const SliderViewPage({Key key, this.height, this.assetPaths, this.isFromUrl = false, this.durationInMilliSeconds = 1000}) : super(key: key);

  @override
  _SliderViewPageState createState() => _SliderViewPageState();
  final double height;
  final List<String> assetPaths;
  final bool isFromUrl;
  final int durationInMilliSeconds;
}

class _SliderViewPageState extends State<SliderViewPage> {
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  int currentPage = 0;
  Timer timer;
  Duration duration;

  @override
  void initState() {
    super.initState();
    runTimer();
  }

  void runTimer() {
    const oneSec = const Duration(seconds: 5);
    timer = Timer.periodic(oneSec, (Timer t) {
      int nextPage = 0;
      if (currentPage < widget.assetPaths.length - 1) {
        nextPage = currentPage + 1;
      }
      try {
        _controller.animateToPage(nextPage, duration: Duration(milliseconds: widget.durationInMilliSeconds), curve: Curves.linear);
      } on Exception catch (e) {} catch (e) {}
    });
  }

  @override
  void dispose() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), borderRadius: BorderRadius.circular(3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Container(
            child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: widget.assetPaths.length,
                itemBuilder: (context, index) {
                  if (widget.isFromUrl) {
                    return CachedImage(
                      height: widget.height,
                      width: double.infinity,
                      emptyImage: "no_image.png",
                      url: widget.assetPaths[index],
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(widget.assetPaths[index]), fit: BoxFit.cover),
                      ),
                    );
                  }
                }),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    widget.assetPaths.length,
                    (index) => buildDot(index: index),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
