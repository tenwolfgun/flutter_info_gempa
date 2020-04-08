import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_earthquake_history.dart';

const String SERVER_FAILURE_MESSAGE =
    "Data belum tersedia, silahkan coba beberapa saat lagi";
const String NO_RESULT_FAILURE_MESSAGE =
    "Data belum tersedia, silahkan coba beberapa saat lagi";
const String CONNECTION_FAILURE_MESSAGE =
    "Tidak dapat tersambung ke server, silahkan periksa koneksi internet anda";

class EarthquakeHistoryBloc
    extends Bloc<EarthquakeHistoryEvent, EarthquakeHistoryState> {
  final GetEarthquakeHistoy getEarthquakeHistoy;

  EarthquakeHistoryBloc({@required this.getEarthquakeHistoy});

  @override
  EarthquakeHistoryState get initialState => InitialEarthquakeHistoryState();

  @override
  Stream<EarthquakeHistoryState> mapEventToState(
    EarthquakeHistoryEvent event,
  ) async* {
    if (event is GetEarthquakeHistoryEvent) {
      yield LoadingState();
      final result = await getEarthquakeHistoy();
      yield result.fold(
        (failure) => ErrorState(errorMessage: _mapFailureToMessage(failure)),
        (data) => LoadedState(
          earthquakeHistory: data,
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
        return NO_RESULT_FAILURE_MESSAGE;
      default:
        return "Unexpected Error";
    }
  }
}
