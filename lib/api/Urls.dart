import 'package:flutter_starter_b/common/constant/Var.dart';

class Urls {
  static const String SERVER_MAIN_DEV = "http://192.168.0.5:80/";
  static const String SERVER_MAIN_PROD = "http://198.167.141.141/";
  static String api_path = getServerMain() + "api/v1/";
  static String getServerMain() {
    if (Var.isServerProd) {
      return SERVER_MAIN_PROD;
    } else {
      return SERVER_MAIN_DEV;
    }
  }

  //autentikasi
  static String autentikasi_signin = api_path + "autentikasi/signin/";
  static String autentikasi_signout = api_path + "autentikasi/signout";
  static String autentikasi_signup = api_path + "autentikasi/signup/";
  static String autentikasi_signup_confirmation = api_path + "autentikasi/signup-confirmation/";
  static String autentikasi_reset_password = api_path + "autentikasi/reset-password/";
  static String autentikasi_reset_password_confirmation = api_path + "autentikasi/reset-password-confirmation/";
  //profile
  static String profile_change_password = api_path + "profile/change-password/";
  static String profile_update = api_path + "profile/update/";
  //file
  static String upload_image = api_path + "upload-image";
}
