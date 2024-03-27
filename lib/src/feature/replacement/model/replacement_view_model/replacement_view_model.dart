import 'package:freezed_annotation/freezed_annotation.dart';
part 'replacement_view_model.freezed.dart';
part 'replacement_view_model.g.dart';

@freezed
class ReplacementViewModel with _$ReplacementViewModel {
  const factory ReplacementViewModel({
    required bool isShowDialogAddBarcodesItems,
  }) = _ReplacementViewModel;

  factory ReplacementViewModel.fromJson(Map<String, dynamic> json) =>
      _$ReplacementViewModelFromJson(json);
}
