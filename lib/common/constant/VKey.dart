import 'Var.dart';

class VKey {
  // DEVELOPMENT
  static const String client_secret_dev = 'UBgFWHgQPtAnT0bMRy5hUf4DwzN8Tlyh9SsqnGe9';
  static const int client_id_dev = 2;

  //PROD
  static const String client_secret_prod = 'LfWwIFel8UUnnLjhZPzp3EjgudAwwpyfmXCvSxwV';
  static const int client_id_prod = 2;

  static String getClientSecret() {
    if (Var.isServerProd) {
      return client_secret_prod;
    } else {
      return client_secret_dev;
    }
  }

  static int getClientId() {
    if (Var.isServerProd) {
      return client_id_dev;
    } else {
      return client_id_dev;
    }
  }

  static const String secret_key = 'CE2E833EEAA7BC4E3BC18E5471253';
}
