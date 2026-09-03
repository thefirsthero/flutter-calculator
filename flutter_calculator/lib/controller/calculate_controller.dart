import 'package:flutter/foundation.dart';
import 'package:flutter_calculator/models/history_entry.dart';
import 'package:math_expressions/math_expressions.dart';

/// Holds the calculator state: the expression being typed, the answer, the
/// live result preview, and the calculation history.
class CalculateController extends ChangeNotifier {
  String _expression = '';
  String _answer = '';
  String _lastExpression = '';
  bool _isEvaluated = false;
  final List<HistoryEntry> _history = <HistoryEntry>[];

  /// The line shown above the main result (e.g. "12+3 = ").
  String get expressionText {
    if (_expression.isNotEmpty) return _expression;
    if (_isEvaluated) return '$_lastExpression =';
    return '';
  }

  /// The main number shown to the user (live preview or final answer).
  String get answerText {
    if (_isEvaluated) return _answer;
    if (_expression.isNotEmpty) return _preview ?? '0';
    return _answer.isNotEmpty ? _answer : '0';
  }

  bool get isTyping => _expression.isNotEmpty && !_isEvaluated;

  /// When true the main number is a dimmed live preview, not a final answer.
  bool get isShowingPreview => isTyping;

  List<HistoryEntry> get history => List<HistoryEntry>.unmodifiable(_history);

  String? get _preview {
    final double? value = _safeEvaluate(_expression);
    return value == null ? null : _format(value);
  }

  /// Appends a digit, dot or operator token.
  void input(String token) {
    if (_isEvaluated) {
      _isEvaluated = false;
      _expression = _isOperator(token) ? '$_answer$token' : _appendToken('', token);
    } else {
      _expression = _appendToken(_expression, token);
    }
    notifyListeners();
  }

  /// Applies percentage to the current operand (e.g. "200+10" -> "200+20").
  void percent() {
    if (_isEvaluated) {
      final double value = double.tryParse(_answer) ?? 0;
      _answer = _format(value / 100);
      _expression = '';
      _isEvaluated = false;
      notifyListeners();
      return;
    }
    if (_expression.isEmpty) return;
    _expression = _applyPercent(_expression);
    notifyListeners();
  }

  /// Inserts the last answer as a value.
  void ans() {
    final String value = _answer.isNotEmpty ? _answer : '0';
    if (_isEvaluated) {
      _expression = value;
      _isEvaluated = false;
    } else {
      if (_expression.isNotEmpty) {
        final String last = _expression[_expression.length - 1];
        if (_isDigitOrClose(last)) _expression += '*';
      }
      _expression += '($value)';
    }
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _answer = '';
    _lastExpression = '';
    _isEvaluated = false;
    notifyListeners();
  }

  void delete() {
    if (_expression.isEmpty) return;
    _expression = _expression.substring(0, _expression.length - 1);
    notifyListeners();
  }

  void equals() {
    if (_expression.isEmpty) return;
    final double? value = _safeEvaluate(_expression);
    if (value == null) {
      _lastExpression = _expression;
      _answer = 'Error';
      _expression = '';
      _isEvaluated = true;
      notifyListeners();
      return;
    }
    final String formatted = _format(value);
    _history.insert(
      0,
      HistoryEntry(expression: _expression, result: formatted),
    );
    if (_history.length > 100) _history.removeLast();
    _lastExpression = _expression;
    _answer = formatted;
    _expression = '';
    _isEvaluated = true;
    notifyListeners();
  }

  /// Reuses a past result as the start of a new calculation.
  void useHistory(HistoryEntry entry) {
    _expression = entry.result;
    _isEvaluated = false;
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  bool _isOperator(String token) =>
      token == '+' || token == '-' || token == '×' || token == '÷';

  bool _isDigitOrClose(String char) =>
      RegExp(r'[0-9.)]').hasMatch(char);

  String _appendToken(String expr, String token) {
    if (expr.isEmpty) {
      if (token == '-') return token;
      if (_isOperator(token)) return expr;
      if (token == '.') return '0.';
      return token;
    }
    final String last = expr[expr.length - 1];
    if (_isOperator(last) && _isOperator(token)) {
      return expr.substring(0, expr.length - 1) + token;
    }
    if (token == '.') {
      final String currentNumber = expr.split(RegExp(r'[+\-×÷]')).last;
      if (currentNumber.contains('.')) return expr;
    }
    return expr + token;
  }

  String _applyPercent(String expr) {
    final RegExpMatch? binary =
        RegExp(r'^(.+?)([+\-×÷])(\d+(\.\d+)?)$').firstMatch(expr);
    if (binary != null) {
      final String left = binary.group(1)!;
      final String op = binary.group(2)!;
      final double right = double.tryParse(binary.group(3)!) ?? 0;
      final double leftValue = _safeEvaluate(left) ?? 0;
      final double newRight =
          (op == '+' || op == '-') ? leftValue * right / 100 : right / 100;
      return '$left$op${_format(newRight)}';
    }
    final RegExpMatch? unary = RegExp(r'^(\d+(\.\d+)?)$').firstMatch(expr);
    if (unary != null) {
      final double value = double.tryParse(unary.group(1)!) ?? 0;
      return _format(value / 100);
    }
    return expr;
  }

  double? _safeEvaluate(String expr) {
    try {
      final String normalized = expr
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('x', '*');
      final Expression parsed = GrammarParser().parse(normalized);
      final double value = parsed.evaluate(EvaluationType.REAL, ContextModel());
      if (value.isNaN || value.isInfinite) return null;
      return value;
    } catch (_) {
      return null;
    }
  }

  String _format(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.roundToDouble() && value.abs() < 1e15) {
      return value.toInt().toString();
    }
    String text = value.toStringAsFixed(10);
    if (text.contains('.')) {
      text = text
          .replaceFirst(RegExp(r'0+$'), '')
          .replaceFirst(RegExp(r'\.$'), '');
    }
    return text;
  }
}
