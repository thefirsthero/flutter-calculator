/// A single completed calculation in the history list.
class HistoryEntry {
  HistoryEntry({
    required this.expression,
    required this.result,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final String expression;
  final String result;
  final DateTime timestamp;
}
