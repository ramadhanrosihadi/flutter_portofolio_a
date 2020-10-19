import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/VString.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/view/slider_view.dart';
import 'package:flutter_starter_b/common/widget/custom_slider.dart';
import 'package:flutter_starter_b/common/widget/text_info.dart';
import 'package:flutter_starter_b/ui/portofolio/model/Portofolio.dart';

class PortofolioItem extends StatefulWidget {
  PortofolioItem({Key key, this.portofolio}) : super(key: key);

  @override
  _PortofolioItemState createState() => _PortofolioItemState();
  final Portofolio portofolio;
}

class _PortofolioItemState extends State<PortofolioItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: (() {
                if (widget.portofolio.screenshot_urls.length > 0) {
                  return SliderViewPage(
                    height: 200,
                    isFromUrl: true,
                    seconds: 15,
                    assetPaths: widget.portofolio.screenshot_urls,
                  );
                } else {
                  return SizedBox();
                }
              }())),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Fun.replaceEmpty(widget.portofolio.title),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Fun.replaceEmpty(widget.portofolio.description),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextInfo(
                        label: 'client',
                        value: widget.portofolio.client_name,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Expanded(
                      child: TextInfo(
                        label: 'year',
                        value: widget.portofolio.year.toString(),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextInfo(
                        label: 'start at',
                        value: widget.portofolio.start_at,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Expanded(
                      child: TextInfo(
                        label: 'end at',
                        value: Fun.replaceEmpty(widget.portofolio.end_at, "ongoing"),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextInfo(
                        label: 'type',
                        value: widget.portofolio.type,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Expanded(
                      child: TextInfo(
                        label: 'stack',
                        value: widget.portofolio.stacks_string,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
