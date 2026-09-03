import 'package:flutter/material.dart';
import 'package:flutter_calculator/controller/calculate_controller.dart';
import 'package:flutter_calculator/controller/theme_controller.dart';
import 'package:flutter_calculator/models/history_entry.dart';
import 'package:flutter_calculator/widgets/calculator_button.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({
    super.key,
    required this.calculator,
    required this.theme,
  });

  final CalculateController calculator;
  final ThemeController theme;

  static const List<String> _keys = <String>[
    'C', 'DEL', '%', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        left: true,
        right: true,
        child: Column(
          children: <Widget>[
            _buildTopBar(context, scheme),
            Expanded(flex: 2, child: _buildDisplay(context, scheme)),
            Expanded(flex: 3, child: _buildKeypad(context, scheme)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            tooltip: 'History',
            onPressed: () => _showHistory(context),
            icon: const Icon(Icons.history_rounded),
            color: scheme.onSurfaceVariant,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: IconButton(
              key: ValueKey<bool>(theme.isDark),
              tooltip: theme.isDark ? 'Light mode' : 'Dark mode',
              onPressed: theme.toggle,
              icon: Icon(
                theme.isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              ),
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplay(BuildContext context, ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: Text(
              calculator.expressionText.isEmpty ? ' ' : calculator.expressionText,
              key: ValueKey<String>(calculator.expressionText),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                calculator.answerText,
                maxLines: 1,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: calculator.isShowingPreview
                      ? scheme.onSurfaceVariant
                      : scheme.onSurface,
                  fontSize: 72,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypad(BuildContext context, ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          for (int row = 0; row < 5; row++)
            Expanded(
              child: Row(
                children: <Widget>[
                  for (int col = 0; col < 4; col++)
                    Expanded(
                      child: _buildButton(context, scheme, row * 4 + col),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, ColorScheme scheme, int index) {
    final (Color background, Color foreground) = _styleFor(index, scheme);
    return CalculatorButton(
      label: _keys[index],
      background: background,
      foreground: foreground,
      onTap: () => _onKeyTap(index),
    );
  }

  (Color, Color) _styleFor(int index, ColorScheme scheme) {
    switch (index) {
      case 0: // C
      case 1: // DEL
        return (scheme.errorContainer, scheme.onErrorContainer);
      case 2: // %
      case 3: // ÷
      case 7: // ×
      case 11: // -
      case 15: // +
        return (scheme.primaryContainer, scheme.onPrimaryContainer);
      case 19: // =
        return (scheme.primary, scheme.onPrimary);
      case 18: // ANS
        return (scheme.tertiaryContainer, scheme.onTertiaryContainer);
      default:
        return (scheme.surfaceContainerHighest, scheme.onSurface);
    }
  }

  void _onKeyTap(int index) {
    switch (index) {
      case 0:
        calculator.clear();
        break;
      case 1:
        calculator.delete();
        break;
      case 2:
        calculator.percent();
        break;
      case 18:
        calculator.ans();
        break;
      case 19:
        calculator.equals();
        break;
      default:
        calculator.input(_keys[index]);
    }
  }

  void _showHistory(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) => _HistorySheet(calculator: calculator),
    );
  }
}

class _HistorySheet extends StatelessWidget {
  const _HistorySheet({required this.calculator});

  final CalculateController calculator;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<HistoryEntry> history = calculator.history;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('History', style: Theme.of(context).textTheme.titleLarge),
                  if (history.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        calculator.clearHistory();
                        Navigator.pop(context);
                      },
                      child: const Text('Clear'),
                    ),
                ],
              ),
            ),
            Flexible(
              child: history.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        'No calculations yet',
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: history.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 1),
                      itemBuilder: (BuildContext context, int index) {
                        final HistoryEntry entry = history[index];
                        return ListTile(
                          onTap: () {
                            calculator.useHistory(entry);
                            Navigator.pop(context);
                          },
                          title: Text(
                            entry.expression,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: scheme.onSurfaceVariant),
                          ),
                          trailing: Text(
                            entry.result,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
