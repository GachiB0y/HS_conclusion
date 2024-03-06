part of 'conclusion_barcode_bloc.dart';

/// {@template conclusion_barcode_state_placeholder}
/// Entity placeholder for ConclusionBarcodeState
/// {@endtemplate}
typedef ConclusionBarcodeEntity = List<String>;

/// {@template conclusion_barcode_state}
/// ConclusionBarcodeState.
/// {@endtemplate}
sealed class ConclusionBarcodeState extends _$ConclusionBarcodeStateBase {
  /// {@macro conclusion_barcode_state}
  const ConclusionBarcodeState({required super.data, required super.message});

  /// Idling state
  /// {@macro conclusion_barcode_state}
  const factory ConclusionBarcodeState.idle({
    required ConclusionBarcodeEntity? data,
    String message,
  }) = ConclusionBarcodeState$Idle;

  /// Processing
  /// {@macro conclusion_barcode_state}
  const factory ConclusionBarcodeState.processing({
    required ConclusionBarcodeEntity? data,
    String message,
  }) = ConclusionBarcodeState$Processing;

  /// Successful
  /// {@macro conclusion_barcode_state}
  const factory ConclusionBarcodeState.successful({
    required ConclusionBarcodeEntity? data,
    String message,
  }) = ConclusionBarcodeState$Successful;

  /// An error has occurred
  /// {@macro conclusion_barcode_state}
  const factory ConclusionBarcodeState.error({
    required ConclusionBarcodeEntity? data,
    String message,
  }) = ConclusionBarcodeState$Error;
}

/// Idling state
/// {@nodoc}
final class ConclusionBarcodeState$Idle extends ConclusionBarcodeState
    with _$ConclusionBarcodeState {
  /// {@nodoc}
  const ConclusionBarcodeState$Idle({
    required super.data,
    super.message = 'Idling',
  });
}

/// Processing
/// {@nodoc}
final class ConclusionBarcodeState$Processing extends ConclusionBarcodeState
    with _$ConclusionBarcodeState {
  /// {@nodoc}
  const ConclusionBarcodeState$Processing({
    required super.data,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class ConclusionBarcodeState$Successful extends ConclusionBarcodeState
    with _$ConclusionBarcodeState {
  /// {@nodoc}
  const ConclusionBarcodeState$Successful({
    required super.data,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class ConclusionBarcodeState$Error extends ConclusionBarcodeState
    with _$ConclusionBarcodeState {
  /// {@nodoc}
  const ConclusionBarcodeState$Error({
    required super.data,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$ConclusionBarcodeState on ConclusionBarcodeState {}

/// Pattern matching for [ConclusionBarcodeState].
typedef ConclusionBarcodeStateMatch<R, S extends ConclusionBarcodeState> = R
    Function(S state);

/// {@nodoc}
@immutable
abstract base class _$ConclusionBarcodeStateBase {
  /// {@nodoc}
  const _$ConclusionBarcodeStateBase({
    required this.data,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final ConclusionBarcodeEntity? data;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasData => data != null;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing =>
      maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [ConclusionBarcodeState].
  R map<R>({
    required ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Idle> idle,
    required ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Processing>
        processing,
    required ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Successful>
        successful,
    required ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Error> error,
  }) =>
      switch (this) {
        final ConclusionBarcodeState$Idle s => idle(s),
        final ConclusionBarcodeState$Processing s => processing(s),
        final ConclusionBarcodeState$Successful s => successful(s),
        final ConclusionBarcodeState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [ConclusionBarcodeState].
  R maybeMap<R>({
    required R Function() orElse,
    ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Idle>? idle,
    ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Processing>?
        processing,
    ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Successful>?
        successful,
    ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [ConclusionBarcodeState].
  R? mapOrNull<R>({
    ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Idle>? idle,
    ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Processing>?
        processing,
    ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Successful>?
        successful,
    ConclusionBarcodeStateMatch<R, ConclusionBarcodeState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
