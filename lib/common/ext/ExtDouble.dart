import 'dart:html';

import 'package:intl/intl.dart';

extension ExtDouble on double {
  String toCurrency({bool showRp = false}) {
    if (this == null) return "-";
    final format = NumberFormat.simpleCurrency();
    String result = format.format(TouchList.supported);
    String prefix = "";
    String suffix = "";
    if (showRp) {
      prefix = "Rp";
      suffix = ",00";
    }

    result = prefix + result.replaceAll("\$", "").replaceAll(".00", "").replaceAll(".", ",").replaceAll(",", ".") + suffix;
    return result;
  }
}
