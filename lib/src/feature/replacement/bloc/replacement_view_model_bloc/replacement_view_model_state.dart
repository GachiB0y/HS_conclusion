part of 'replacement_view_model_bloc.dart';

/// {@template replacement_view_model_state_placeholder}
/// Entity placeholder for ReplacementViewModelState
/// {@endtemplate}
typedef ReplacementViewModelEntity = ReplacementViewModel;

/// {@template replacement_view_model_state}
/// ReplacementViewModelState.
/// {@endtemplate}
sealed class ReplacementViewModelState extends _$ReplacementViewModelStateBase {
  /// {@macro replacement_view_model_state}
  const ReplacementViewModelState({
    required super.data,
    required super.message,
  });

  /// Idling state
  /// {@macro replacement_view_model_state}
  const factory ReplacementViewModelState.idle({
    required ReplacementViewModelEntity? data,
    String message,
  }) = ReplacementViewModelState$Idle;

  /// Processing
  /// {@macro replacement_view_model_state}
  const factory ReplacementViewModelState.processing({
    required ReplacementViewModelEntity? data,
    String message,
  }) = ReplacementViewModelState$Processing;

  /// Successful
  /// {@macro replacement_view_model_state}
  const factory ReplacementViewModelState.successful({
    required ReplacementViewModelEntity? data,
    String message,
  }) = ReplacementViewModelState$Successful;

  /// An error has occurred
  /// {@macro replacement_view_model_state}
  const factory ReplacementViewModelState.error({
    required ReplacementViewModelEntity? data,
    String message,
  }) = ReplacementViewModelState$Error;
}

/// Idling state
/// {@nodoc}
final class ReplacementViewModelState$Idle extends ReplacementViewModelState
    with _$ReplacementViewModelState {
  /// {@nodoc}
  const ReplacementViewModelState$Idle({
    required super.data,
    super.message = 'Idling',
  });
}

/// Processing
/// {@nodoc}
final class ReplacementViewModelState$Processing
    extends ReplacementViewModelState with _$ReplacementViewModelState {
  /// {@nodoc}
  const ReplacementViewModelState$Processing({
    required super.data,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class ReplacementViewModelState$Successful
    extends ReplacementViewModelState with _$ReplacementViewModelState {
  /// {@nodoc}
  const ReplacementViewModelState$Successful({
    required super.data,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class ReplacementViewModelState$Error extends ReplacementViewModelState
    with _$ReplacementViewModelState {
  /// {@nodoc}
  const ReplacementViewModelState$Error({
    required super.data,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$ReplacementViewModelState on ReplacementViewModelState {}

/// Pattern matching for [ReplacementViewModelState].
typedef ReplacementViewModelStateMatch<R, S extends ReplacementViewModelState>
    = R Function(S state);

/// {@nodoc}
@immutable
abstract base class _$ReplacementViewModelStateBase {
  /// {@nodoc}
  const _$ReplacementViewModelStateBase({
    required this.data,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final ReplacementViewModelEntity? data;

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

  /// Pattern matching for [ReplacementViewModelState].
  R map<R>({
    required ReplacementViewModelStateMatch<R, ReplacementViewModelState$Idle>
        idle,
    required ReplacementViewModelStateMatch<R,
            ReplacementViewModelState$Processing>
        processing,
    required ReplacementViewModelStateMatch<R,
            ReplacementViewModelState$Successful>
        successful,
    required ReplacementViewModelStateMatch<R, ReplacementViewModelState$Error>
        error,
  }) =>
      switch (this) {
        final ReplacementViewModelState$Idle s => idle(s),
        final ReplacementViewModelState$Processing s => processing(s),
        final ReplacementViewModelState$Successful s => successful(s),
        final ReplacementViewModelState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [ReplacementViewModelState].
  R maybeMap<R>({
    required R Function() orElse,
    ReplacementViewModelStateMatch<R, ReplacementViewModelState$Idle>? idle,
    ReplacementViewModelStateMatch<R, ReplacementViewModelState$Processing>?
        processing,
    ReplacementViewModelStateMatch<R, ReplacementViewModelState$Successful>?
        successful,
    ReplacementViewModelStateMatch<R, ReplacementViewModelState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [ReplacementViewModelState].
  R? mapOrNull<R>({
    ReplacementViewModelStateMatch<R, ReplacementViewModelState$Idle>? idle,
    ReplacementViewModelStateMatch<R, ReplacementViewModelState$Processing>?
        processing,
    ReplacementViewModelStateMatch<R, ReplacementViewModelState$Successful>?
        successful,
    ReplacementViewModelStateMatch<R, ReplacementViewModelState$Error>? error,
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
