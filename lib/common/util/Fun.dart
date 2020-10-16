import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/constant/Var.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';

class Fun {
  static final log = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static AppBar defaultAppBar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[800], fontSize: 17),
      ),
      iconTheme: IconThemeData(
        color: Colors.grey[800],
        size: 20,
      ),
      brightness: Brightness.light,
    );
  }

  static Future<String> currentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "v${packageInfo.version} (${packageInfo.buildNumber})";
  }

  static Future<String> currentVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  static Future<String> currentVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> deviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      var isPhysicalDevice = androidInfo.isPhysicalDevice ? "" : " [Virtual]";
      return 'Android $release (SDK $sdkInt), $manufacturer $model $isPhysicalDevice';
    }
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      var isPhysicalDevice = iosInfo.isPhysicalDevice ? "" : " [Virtual]";
      return 'iOS $systemName $version, $name $model $isPhysicalDevice';
    }
    return "-";
  }

  static Future<bool> createDialog(
    BuildContext context, {
    String title = Var.appName,
    String message,
    bool withBackButton = true,
    String positiveText = "OK",
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          content: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
          ),
          actions: [
            if (withBackButton)
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                elevation: 5.0,
                child: Text(
                  'Kembali',
                  style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
                ),
              ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              elevation: 5.0,
              child: Text(
                positiveText,
                style: TextStyle(fontWeight: FontWeight.w700, color: VColor.colorPrimary),
              ),
            )
          ],
        );
      },
    );
  }
}
