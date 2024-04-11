// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_model.freezed.dart';
part 'gallery_model.g.dart';

@freezed
class GalleryModel with _$GalleryModel {

  const GalleryModel._();

  const factory GalleryModel({
    @Default([])
    final List<String> images,

  }) = _GalleryModel;

  factory GalleryModel.fromJson(Map<String, dynamic> json) => _$GalleryModelFromJson(json);
}
