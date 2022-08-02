import 'dart:io';

import 'package:copper/utils/human_date_converter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/annotations.dart';
import 'package:intl/date_symbol_data_local.dart';

class NoteDisplayDate implements HumanDateConverter {
  const NoteDisplayDate();
  @override
  Future<String> getReadableDate(DateTime dateTime, {String? locale}) async {
    var now = DateTime.now().toLocal();

    final String dateLocale = locale ?? Platform.localeName;

    var hour = dateTime.hour;
    var minute = dateTime.minute;

    var hourFormat = NumberFormat("00").format(hour);
    var minuteFormat = NumberFormat("00").format(minute);

    var dateTimeDifference = now.difference(dateTime);

    var isToday = dateTimeDifference.inDays == 0;
    var isYesterday = dateTimeDifference.inDays == 1;
    if (isToday) {
      return 'Today $hourFormat:$minuteFormat';
    } else if (isYesterday) {
      return 'Yesterday $hourFormat:$minuteFormat';
    }
    await initializeDateFormatting();
    return '${DateFormat.yMMMMd(dateLocale).format(dateTime)} $hourFormat:$minuteFormat';
  }
}
