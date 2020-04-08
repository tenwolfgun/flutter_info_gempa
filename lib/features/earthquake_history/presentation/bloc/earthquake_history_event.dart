import 'package:equatable/equatable.dart';

abstract class EarthquakeHistoryEvent extends Equatable {
  const EarthquakeHistoryEvent();
}

class GetEarthquakeHistoryEvent extends EarthquakeHistoryEvent {
  @override
  List<Object> get props => [];
}
