import 'package:freezed_annotation/freezed_annotation.dart';

part 'alternative_entity.freezed.dart';
part 'alternative_entity.g.dart';

@freezed
abstract class AlternativeEntity with _$AlternativeEntity {
  // dart run build_runner build --delete-conflicting-outputs
  AlternativeEntity._();

  factory AlternativeEntity({
    int? id,
    String? titulo,
  }) = _AlternativeEntity;

  factory AlternativeEntity.fromJson(Map<String, dynamic> json) =>
      _$AlternativeEntityFromJson(json);
}
