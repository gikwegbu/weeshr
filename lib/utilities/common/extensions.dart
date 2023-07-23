
// Strip white spaces on Strings
extension StripWhiteSpace on String {
  String stripWhiteSpaces() {
    return replaceAll(' ', '');
  }
}