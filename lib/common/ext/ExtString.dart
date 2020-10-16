extension ExtString on String {
  String replaceEmpty({String replaceWith}) {
    if (this == null || this == 'null') return replaceWith;
    return this;
  }
}
