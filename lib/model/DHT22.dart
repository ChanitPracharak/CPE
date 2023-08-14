import 'package:flutter/material.dart';

class DHT22 {
  // Temp
  double? DataTemp;
  double? TempStartCon;
  double? TempEndCon;
  String? TempStartTime;
  String? TempEndTime;
  String? TempCombineData;
  String? ModeTemp;
  bool? StatusTemp;
  int? DimmerHeater;

  // Hum
  int? DataHum;
  int? HumStartCon;
  int? HumEndCon;
  String? HumStartTime;
  String? HumEndTime;
  String? HumCombineData;
  String? ModeHum;
  bool? StatusHum;
  int? DimmerHum;

  DHT22({
    this.DataTemp,
    this.DataHum,
    this.TempStartTime,
    this.TempEndTime,
    this.TempCombineData,
    this.HumStartTime,
    this.HumEndTime,
    this.HumCombineData,
  });
}
