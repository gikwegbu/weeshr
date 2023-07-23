import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResponse extends Equatable {
  // final int? code;
  final String? code;
  final bool isError;
  final Object? result;
  final String? message;
  final String? description;

  /// message , code and description

  const ApiResponse({
    this.result,
    this.code,
    this.message,
    this.description,
    this.isError = false,
  });

  ApiResponse copyWith({
    String? code,
    bool? isError,
    Object? result,
    String? message,
    String? description,
  }) {
    return ApiResponse(
      code: code ?? this.code,
      isError: isError ?? this.isError,
      result: result ?? this.result,
      message: message ?? this.message,
      description: description ?? this.description,
    );
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  List<dynamic> get props => [
        result,
        code,
        message,
        isError,
        description,
      ];
}

@JsonSerializable()
class ResultMessage extends Equatable {
  final String? message;
  final String? token;
  final DateTime? expiry;
  final Object? user;

  const ResultMessage({this.message, this.token, this.expiry, this.user});

  factory ResultMessage.fromJson(Map<String, dynamic> json) =>
      _$ResultMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ResultMessageToJson(this);

  @override
  List<dynamic> get props => [message, token, expiry, user];
}
