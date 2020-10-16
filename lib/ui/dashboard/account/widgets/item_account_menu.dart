import 'package:flutter/material.dart';

class ItemAccountMenu extends StatelessWidget {
  final Function onPressed;
  final String title;
  final String subtitle;
  final String assetPath;
  final IconData iconData;

  const ItemAccountMenu({Key key, this.onPressed, this.title, this.subtitle, this.assetPath, this.iconData}) : super(key: key);

  Widget getIcon() {
    if (iconData != null) {
      return Icon(iconData);
    } else if (assetPath != null) {
      return Image.asset(
        assetPath,
        height: 20,
      );
    }
    return SizedBox(
      width: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    getIcon(),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(fontSize: 15),
                        ),
                        Visibility(
                          visible: subtitle != null ? true : false,
                          child: Container(
                            margin: EdgeInsets.only(top: 2),
                            child: Text(
                              subtitle != null ? subtitle : "-",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.chevron_right)
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
          indent: 15,
          endIndent: 0,
        ),
      ],
    );
  }
}
