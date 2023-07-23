import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City extends Equatable {
  final String? name;
  final double? lat;
  final double? lng;

  const City({this.name, this.lat, this.lng});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);


  List<City> fromList(List items) {
    if (items.isNotEmpty) {
      return items.map((e) => City.fromJson(e)).toList();
    }
    return [];
  }

  @override
  List<Object?> get props => [
        name,
        lat,
        lng,
      ];
}
