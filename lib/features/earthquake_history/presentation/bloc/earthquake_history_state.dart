import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/earthquake_history.dart';

abstract class EarthquakeHistoryState extends Equatable {
  const EarthquakeHistoryState();
}

class InitialEarthquakeHistoryState extends EarthquakeHistoryState {
  @override
  List<Object> get props => [];
}

class LoadingState extends EarthquakeHistoryState {
  @override
  List<Object> get props => [];
}

class LoadedState extends EarthquakeHistoryState {
  final EarthquakeHistory earthquakeHistory;

  LoadedState({@required this.earthquakeHistory});

  @override
  List<Object> get props => [earthquakeHistory];
}

class ErrorState extends EarthquakeHistoryState {
  final String errorMessage;

  ErrorState({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
