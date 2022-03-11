// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_task1/domain/entities/sunrise_entity.dart';

part 'sunrise_model.freezed.dart';
part 'sunrise_model.g.dart';

@freezed
class SunriseModel with _$SunriseModel {
  const SunriseModel._();
  factory SunriseModel({
    String? sunrise,
    String? sunset,
    @JsonKey(name: 'solar_noon') String? solarNoon,
    @JsonKey(name: 'day_length') String? dayLength,
    @JsonKey(name: 'civil_twilight_begin') String? civilTwilightBegin,
    @JsonKey(name: 'civil_twilight_end') String? civilTwilightEnd,
    @JsonKey(name: 'nautical_twilight_begin') String? nauticalTwilightBegin,
    @JsonKey(name: 'nautical_twilight_end') String? nauticalTwilightEnd,
    @JsonKey(name: 'astronomical_twilight_begin')
        String? astronomicalTwilightBegin,
    @JsonKey(name: 'astronomical_twilight_end') String? astronomicalTwilightEnd,
  }) = _SunriseModel;

  factory SunriseModel.fromJson(Map<String, dynamic> json) =>
      _$SunriseModelFromJson(json);

  SunriseEntity toEntity() => SunriseEntity(
        sunrise: sunrise ?? "",
        sunset: sunset ?? "",
        solarNoon: solarNoon ?? "",
        dayLength: dayLength ?? "",
        civilTwilightBegin: civilTwilightBegin ?? "",
        civilTwilightEnd: civilTwilightEnd ?? "",
        nauticalTwilightBegin: nauticalTwilightBegin ?? "",
        nauticalTwilightEnd: nauticalTwilightEnd ?? "",
        astronomicalTwilightBegin: astronomicalTwilightBegin ?? "",
        astronomicalTwilightEnd: astronomicalTwilightEnd ?? "",
      );
}
