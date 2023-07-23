import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_session.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrentSession extends Equatable {
  final double? lat;
  final double? long;
  final String? city;

  const CurrentSession({
    this.lat,
    this.long,
    this.city,
  });

  CurrentSession copyWith({
    double? lat,
    double? long,
    String? city,
  }) {
    return CurrentSession(
      lat: lat ?? this.lat,
long: long ?? this.long,
city: city ?? this.city,
    );
  }

  factory CurrentSession.fromJson(Map<String, dynamic> json) =>
      _$CurrentSessionFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentSessionToJson(this);

  @override
  List<Object?> get props => [
        lat,
long,
city,
      ];
}
