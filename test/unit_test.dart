import 'package:copper/utils/date_time_helper.dart';
import 'package:copper/utils/random_helper.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

void main() {
  group('Timestamp to human-readable date', () {
    //TODO: Today => Today 17:48
    //TODO: Yesterday => Yesterday 17:48
    //TODO: Otherwise => 22 July 2022 17:48
    test('should return today', () async {
      final now = DateTime.now().toLocal();

      var hour = now.hour;
      var minute = now.minute;

      var hourFormat = NumberFormat("00").format(hour);
      var minuteFormat = NumberFormat("00").format(minute);

    await expectLater(now.millisecondsSinceEpoch.toReadableDate(),
          completion('Today $hourFormat:$minuteFormat'));
    });
    test('should return yesterday', () async {
      final yesterday =
          DateTime.now().toLocal().subtract(const Duration(days: 1));

      var hour = yesterday.hour;
      var minute = yesterday.minute;

      var dateDiff = DateTime.now().difference(yesterday);

      var hourFormat = NumberFormat("00").format(hour);
      var minuteFormat = NumberFormat("00").format(minute);

      await expectLater(yesterday.millisecondsSinceEpoch.toReadableDate(),
          completion('Yesterday $hourFormat:$minuteFormat'));
    });
    test('should return human-readable date in en_GB', () async {
      final dateTime =
          DateTime.fromMillisecondsSinceEpoch(1657328649000).toLocal();
      await expectLater(
          dateTime.millisecondsSinceEpoch.toReadableDate(locale: 'en_GB'),
          completion('9 July 2022 08:04'));
    });

    test('should return human-readable date in en_US', () async {
      final dateTime =
          DateTime.fromMillisecondsSinceEpoch(1657328649000).toLocal();
      await expectLater(
          dateTime.millisecondsSinceEpoch.toReadableDate(locale: 'en_US'),
          completion('July 9, 2022 08:04'));
    });
  });
  test('get getUniqueId should return 24 chars',
      () => expect(RandomHelper.getUniqueId().length, 24));
}
