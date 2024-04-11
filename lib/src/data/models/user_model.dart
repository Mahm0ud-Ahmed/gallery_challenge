// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {

  const UserModel._();

  const factory UserModel({
    required final _User user,
    required final String token,

  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}


@freezed
class _User with _$User {

  const _User._();

  const factory _User({
    required final int id,
    required final String name,
    required final String email,

  }) = User;

  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}


