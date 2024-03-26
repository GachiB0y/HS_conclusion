part of 'replacement_bloc.dart';

/// {@template replacement_state_placeholder}
/// Entity placeholder for ReplacementState
/// {@endtemplate}
typedef ReplacementEntity = ModelsPallet;

/// {@template replacement_state}
/// ReplacementState.
/// {@endtemplate}
sealed class ReplacementState extends _$ReplacementStateBase {
  /// {@macro replacement_state}
  const ReplacementState({required super.data, required super.message});

  /// Idling state
  /// {@macro replacement_state}
  const factory ReplacementState.idle({
    required ReplacementEntity? data,
    String message,
  }) = ReplacementState$Idle;

  /// Processing
  /// {@macro replacement_state}
  const factory ReplacementState.processing({
    required ReplacementEntity? data,
    String message,
  }) = ReplacementState$Processing;

  /// Successful
  /// {@macro replacement_state}
  const factory ReplacementState.successful({
    required ReplacementEntity? data,
    String message,
  }) = ReplacementState$Successful;

  /// An error has occurred
  /// {@macro replacement_state}
  const factory ReplacementState.error({
    required ReplacementEntity? data,
    String message,
  }) = ReplacementState$Error;
}

/// Idling state
/// {@nodoc}
final class ReplacementState$Idle extends ReplacementState
    with _$ReplacementState {
  /// {@nodoc}
  const ReplacementState$Idle({required super.data, super.message = 'Idling'});
}

/// Processing
/// {@nodoc}
final class ReplacementState$Processing extends ReplacementState
    with _$ReplacementState {
  /// {@nodoc}
  const ReplacementState$Processing({
    required super.data,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class ReplacementState$Successful extends ReplacementState
    with _$ReplacementState {
  /// {@nodoc}
  const ReplacementState$Successful({
    required super.data,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class ReplacementState$Error extends ReplacementState
    with _$ReplacementState {
  /// {@nodoc}
  const ReplacementState$Error({
    required super.data,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$ReplacementState on ReplacementState {}

/// Pattern matching for [ReplacementState].
typedef ReplacementStateMatch<R, S extends ReplacementState> = R Function(
  S state,
);

/// {@nodoc}
@immutable
abstract base class _$ReplacementStateBase {
  /// {@nodoc}
  const _$ReplacementStateBase({required this.data, required this.message});

  /// Data entity payload.
  @nonVirtual
  final ReplacementEntity? data;

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

  /// Pattern matching for [ReplacementState].
  R map<R>({
    required ReplacementStateMatch<R, ReplacementState$Idle> idle,
    required ReplacementStateMatch<R, ReplacementState$Processing> processing,
    required ReplacementStateMatch<R, ReplacementState$Successful> successful,
    required ReplacementStateMatch<R, ReplacementState$Error> error,
  }) =>
      switch (this) {
        final ReplacementState$Idle s => idle(s),
        final ReplacementState$Processing s => processing(s),
        final ReplacementState$Successful s => successful(s),
        final ReplacementState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [ReplacementState].
  R maybeMap<R>({
    required R Function() orElse,
    ReplacementStateMatch<R, ReplacementState$Idle>? idle,
    ReplacementStateMatch<R, ReplacementState$Processing>? processing,
    ReplacementStateMatch<R, ReplacementState$Successful>? successful,
    ReplacementStateMatch<R, ReplacementState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [ReplacementState].
  R? mapOrNull<R>({
    ReplacementStateMatch<R, ReplacementState$Idle>? idle,
    ReplacementStateMatch<R, ReplacementState$Processing>? processing,
    ReplacementStateMatch<R, ReplacementState$Successful>? successful,
    ReplacementStateMatch<R, ReplacementState$Error>? error,
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
