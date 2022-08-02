import 'dart:math';
/// convert from javascript https://gist.github.com/solenoid/1372386
class RandomHelper {
  static String getUniqueId() {
    final timestamp =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000 | 0).toRadixString(16);
    return timestamp +
        'xxxxxxxxxxxxxxxx'.replaceAllMapped(RegExp('x'), (match) {
          return (Random().nextInt(16)).toRadixString(16).toLowerCase();
        });
  }
}
