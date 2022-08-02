import 'package:copper/utils/human_date_converter.dart';
import 'package:copper/utils/note_display_date.dart';
import 'package:intl/intl.dart';

extension DateTimeHelper on int {
  Future<String> toReadableDate({HumanDateConverter humanDateConverter = const NoteDisplayDate(), String? locale}) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    return humanDateConverter.getReadableDate(dateTime, locale: locale);
  }
}
