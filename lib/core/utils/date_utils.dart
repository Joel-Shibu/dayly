/// Small date helpers used across the app.
class DateUtils {
  /// Returns formatted YYYY-MM-DD for a [DateTime].
  static String toIsoDate(DateTime dt) => '${dt.year.toString().padLeft(4, '0')}-'
      '${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')}';
}
