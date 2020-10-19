import 'dart:async';

import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  CustomSlider({Key key, this.height, this.assetPaths, this.seconds = 10}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();

  final double height;
  final List<String> assetPaths;
  final int seconds;
}

class _CustomSliderState extends State<CustomSlider> {
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  int currentPage = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
    runTimer();
  }

  void runTimer() {
    timer = Timer.periodic(Duration(seconds: widget.seconds), (Timer t) {
      int nextPage = 0;
      if (currentPage < widget.assetPaths.length - 1) {
        nextPage = currentPage + 1;
      }
      try {
        _controller.animateToPage(nextPage, duration: Duration(milliseconds: 500), curve: Curves.linear);
      } on Exception catch (e) {
        print("main_dashbaord e: $e");
      } catch (e) {
        print("main_dashbaord catch e: $e");
      }
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
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(widget.assetPaths[index]), fit: BoxFit.cover),
                    ),
                  );
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
