// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      result: json['result'],
      code: json['code'] as String?,
      message: json['message'] as String?,
      description: json['description'] as String?,
      isError: json['isError'] as bool? ?? false,
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'isError': instance.isError,
      'result': instance.result,
      'message': instance.message,
      'description': instance.description,
    };

ResultMessage _$ResultMessageFromJson(Map<String, dynamic> json) =>
    ResultMessage(
      message: json['message'] as String?,
      token: json['token'] as String?,
      expiry: json['expiry'] == null
          ? null
          : DateTime.parse(json['expiry'] as String),
      user: json['user'],
    );

Map<String, dynamic> _$ResultMessageToJson(ResultMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'expiry': instance.expiry?.toIso8601String(),
      'user': instance.user,
    };
