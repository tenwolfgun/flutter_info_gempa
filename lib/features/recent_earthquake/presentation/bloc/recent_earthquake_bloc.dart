import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_recent_earthquake.dart';

const String NO_RESULT_FAILURE_MESSSAGE =
    "Data belum tersedia, silahkan coba beberapa saat lagi";
const String SERVER_FAILURE_MESSAGE = "Tidak dapat mengambil data dari server";
const String CONNECTION_FAILURE_MESSAGE =
    "Tidak dapat tersambung ke server, silahkan periksa koneksi internet anda";

class RecentEarthquakeBloc
    extends Bloc<RecentEarthquakeEvent, RecentEarthquakeState> {
  final GetRecentEarthquake getRecentEarthquake;

  RecentEarthquakeBloc({@required this.getRecentEarthquake});

  @override
  RecentEarthquakeState get initialState => InitialRecentEarthquakeState();

  @override
  Stream<RecentEarthquakeState> mapEventToState(
    RecentEarthquakeEvent event,
  ) async* {
    if (event is GetRecentEearthquakeEvent) {
      yield LoadingState();
      final result = await getRecentEarthquake();
      yield result.fold(
        (failure) => ErrorState(errorMessage: _mapFailureToMessage(failure)),
        (data) => LoadedState(
          recentEarthquake: data,
          isSame: true,
        ),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case ConnectionFailure:
        return CONNECTION_FAILURE_MESSAGE;
      case NoResultFailure:
        return NO_RESULT_FAILURE_MESSSAGE;
      default:
        return "Unexpected Error";
    }
  }
}
