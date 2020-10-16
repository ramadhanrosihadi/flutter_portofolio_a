import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({Key key, this.height, this.width, this.url, this.emptyImage = "user.png"}) : super(key: key);

  final double height;
  final double width;
  final String url;
  final String emptyImage;

  @override
  Widget build(BuildContext context) {
    print("cachedImage url: $url");
    if (url == "") {
      return Image(
        fit: BoxFit.fill,
        height: height,
        width: width,
        image: AssetImage('assets/images/$emptyImage'),
      );
    } else {
      return CachedNetworkImage(
          fit: BoxFit.fill,
          height: height,
          width: width,
          imageUrl: url,
          placeholder: (context, url) {
            return Image(
              fit: BoxFit.fill,
              height: height,
              width: width,
              image: AssetImage('assets/images/$emptyImage'),
            );
          },
          errorWidget: (context, url, error) {
            return Image(
              fit: BoxFit.fill,
              height: height,
              width: width,
              image: AssetImage('assets/images/$emptyImage'),
            );
          });
    }
  }
}
