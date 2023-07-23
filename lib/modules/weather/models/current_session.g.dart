// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentSession _$CurrentSessionFromJson(Map<String, dynamic> json) =>
    CurrentSession(
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      city: json['city'] as String?,
    );

Map<String, dynamic> _$CurrentSessionToJson(CurrentSession instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'city': instance.city,
    };
