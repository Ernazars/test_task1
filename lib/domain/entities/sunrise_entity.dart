import 'package:freezed_annotation/freezed_annotation.dart';

part 'sunrise_entity.freezed.dart';

@freezed
class SunriseEntity with _$SunriseEntity {
  const factory SunriseEntity({
    required String sunrise,
    required String sunset,
    required String solarNoon,
    required String dayLength,
    required String civilTwilightBegin,
    required String civilTwilightEnd,
    required String nauticalTwilightBegin,
    required String nauticalTwilightEnd,
    required String astronomicalTwilightBegin,
    required String astronomicalTwilightEnd,
  }) = _SunriseEntity;
}
