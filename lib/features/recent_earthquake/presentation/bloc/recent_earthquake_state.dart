import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/recent_earthquake.dart';

abstract class RecentEarthquakeState extends Equatable {
  const RecentEarthquakeState();
}

class InitialRecentEarthquakeState extends RecentEarthquakeState {
  @override
  List<Object> get props => [];
}

class LoadedState extends RecentEarthquakeState {
  final RecentEarthquake recentEarthquake;
  final bool isSame;

  LoadedState({
    @required this.recentEarthquake,
    @required this.isSame,
  });

  LoadedState copyWith({
    RecentEarthquake recentEarthquake,
    bool isSame,
  }) {
    return LoadedState(
      recentEarthquake: recentEarthquake ?? this.recentEarthquake,
      isSame: isSame ?? this.isSame,
    );
  }

  @override
  List<Object> get props => [recentEarthquake, isSame];
}

class LoadingState extends RecentEarthquakeState {
  @override
  List<Object> get props => [];
}

class ErrorState extends RecentEarthquakeState {
  final String errorMessage;

  ErrorState({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
