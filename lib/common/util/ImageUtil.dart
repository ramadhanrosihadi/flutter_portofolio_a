import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_starter_b/common/constant/Var.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ImageUtil {
  static Future<File> compressImage(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path + "/temp.jpg";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      rotate: 0,
    );
    return result;
  }

  static Future<String> getImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: imageSource);
    return pickedFile.path;
  }

  static void createDialogAmbilGambar(BuildContext context, Function onPicked) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Var.appName),
          content: Text("Kamu ingin ambil gambarnya dari mana?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Galeri"),
              onPressed: () async {
                Navigator.of(context).pop();
                ImageUtil.getImage(ImageSource.gallery).then((value) {
                  onPicked(value);
                });
              },
            ),
            FlatButton(
              child: Text("Kamera"),
              onPressed: () async {
                Navigator.of(context).pop();
                ImageUtil.getImage(ImageSource.camera).then((value) {
                  onPicked(value);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
