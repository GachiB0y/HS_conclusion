import 'package:flutter/widgets.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';

/// {@template replacment_scope}
/// ReplacmentScope widget.
/// {@endtemplate}
class ReplacmentScope extends StatefulWidget {
  /// {@macro replacment_scope}
  const ReplacmentScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  static _InheritedReplacmentScope of(
    BuildContext context, {
    bool listen = true,
  }) =>
      _InheritedReplacmentScope.of(context, listen: listen);

  @override
  State<ReplacmentScope> createState() => _ReplacmentScopeState();
}

/// State for widget ReplacmentScope.
class _ReplacmentScopeState extends State<ReplacmentScope> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(ReplacmentScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }

  /* #endregion */

  bool checkDuplicateBarcode(
    List<Box> array,
    String barcode,
  ) {
    for (final box in array) {
      if (box.barcode == barcode) {
        return true;
      }

      for (final item in box.items) {
        if (item.barcode == barcode) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) => _InheritedReplacmentScope(
        state: this,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree.
class _InheritedReplacmentScope extends InheritedWidget {
  const _InheritedReplacmentScope({
    required this.state,
    required super.child,
  });

  final _ReplacmentScopeState state;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// For example: `ReplacmentScope.maybeOf(context)`.
  static _InheritedReplacmentScope? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_InheritedReplacmentScope>()
          : context
              .getElementForInheritedWidgetOfExactType<
                  _InheritedReplacmentScope>()
              ?.widget as _InheritedReplacmentScope?;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedReplacmentScope of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// For example: `ReplacmentScope.of(context)`.
  static _InheritedReplacmentScope of(
    BuildContext context, {
    bool listen = true,
  }) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant _InheritedReplacmentScope oldWidget) =>
      false;
}
