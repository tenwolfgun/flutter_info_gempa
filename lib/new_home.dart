import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'core/utils/utils.dart';
import 'features/earthquake_history/presentation/bloc/bloc.dart' as eh;
import 'features/earthquake_history/presentation/pages/earthquake_history.dart';
import 'features/recent_earthquake/presentation/bloc/bloc.dart';
import 'features/recent_earthquake/presentation/pages/recent_earthquake.dart';
import 'injection_container.dart';

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RecentEarthquakeBloc recentEarthquakeBloc = sl<RecentEarthquakeBloc>();
  final ItemScrollController scrollController = ItemScrollController();
  final Utils utils = Utils();
  final eh.EarthquakeHistoryBloc earthquakeHistoryBloc =
      sl<eh.EarthquakeHistoryBloc>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Completer<GoogleMapController> _mapController = Completer();
  double lat;
  double lng;
  double histroyLat;
  double historyLng;
  String _coordinate;
  String _historyCoordinate;
  List<String> _splitCoordinate;
  List<String> _splitHistoryCoordinate;
  double _panelHeightOpen;
  Set<Marker> _marker = Set();
  Set<Marker> _historyMarker = Set();
  bool _isHistory = false;
  TabController _tabController;
  int selected = 100;
  bool _isHybrid = true;
  final double _fabHeight = 100;

  @override
  void initState() {
    _firebaseMessaging.subscribeToTopic("gempa");
    _getToken();
    _getMessage();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(_handleChangeTab);
    recentEarthquakeBloc.add(GetRecentEearthquakeEvent());
    earthquakeHistoryBloc.add(eh.GetEarthquakeHistoryEvent());
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleChangeTab() {
    if (_tabController.index == 1) {
      setState(() {
        _isHistory = true;
      });
      utils.goToMapMarker(
        lat: lat,
        lng: lng,
        mapController: _mapController,
      );
    } else {
      setState(() {
        _isHistory = false;
      });
      lat != null && lng != null
          ? utils.goToMapMarker(
              lat: lat,
              lng: lng,
              mapController: _mapController,
            )
          : print(null);
    }
  }

  void _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

  void _getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on message $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 2131, allowFontScaling: false);
    _panelHeightOpen = MediaQuery.of(context).size.height * .50;

    return MultiBlocProvider(
      providers: [
        BlocProvider<RecentEarthquakeBloc>(
          create: (context) => recentEarthquakeBloc,
        ),
        BlocProvider<eh.EarthquakeHistoryBloc>(
          create: (context) => earthquakeHistoryBloc,
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            SlidingUpPanel(
              color: Colors.white,
              maxHeight: _panelHeightOpen,
              minHeight: 200.h,
              parallaxEnabled: true,
              parallaxOffset: .3,
              body: _buildBody(),
              panel: _panel(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return lat != null && lng != null
        ? Stack(
            children: <Widget>[
              Positioned.fill(
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: LatLng(lat, lng), zoom: 5),
                  onMapCreated: _onMapCreated,
                  markers: _isHistory ? _historyMarker : _marker,
                  compassEnabled: false,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  mapType: _isHybrid ? MapType.hybrid : MapType.normal,
                ),
              ),
              Positioned(
                right: 20.w,
                bottom: _fabHeight,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isHybrid = !_isHybrid;
                    });
                  },
                  mini: true,
                  child: Icon(
                    Icons.layers,
                    color: Colors.black,
                    size: 70.sp,
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 16.w,
                      bottom: 16.w,
                      left: 8.w,
                      right: 8.w,
                    ),
                    child: Text(
                      "Sumber data: Badan Meteorologi, Klimatologi, dan Geofisika",
                      style: TextStyle(
                        fontSize: 33.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  Widget _panel() {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: MediaQuery.of(context).size.width * 0.45,
            right: MediaQuery.of(context).size.width * 0.45,
            top: 25.h,
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
              height: 10.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.8,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Color(0xff1a73e8),
                labelColor: Color(0xff1a73e8),
                unselectedLabelColor: Color(0xff5f6368),
                labelStyle: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: MD2Indicator(
                  indicatorHeight: 3,
                  indicatorColor: Color(0xff1a73e8),
                  indicatorSize: MD2IndicatorSize.normal,
                ),
                tabs: <Widget>[
                  Tab(text: "Gempa terkini"),
                  Tab(text: "Riwayat gempa"),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 200.h),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: <Widget>[
                  MultiBlocListener(
                    listeners: [
                      BlocListener<RecentEarthquakeBloc, RecentEarthquakeState>(
                        listener: (context, RecentEarthquakeState state) {
                          if (state is ErrorState) {
                            utils.showSnackBar(
                              scaffoldKey: _scaffoldKey,
                              message: state.errorMessage,
                              color: Colors.red,
                              child: Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            );
                          } else if (state is LoadedState) {
                            _coordinate = state.recentEarthquake.infogempa.gempa
                                .point.coordinates;
                            _splitCoordinate = _coordinate.split(',');
                            setState(() {
                              lat =
                                  double.tryParse(_splitCoordinate[1]) ?? null;
                              lng =
                                  double.tryParse(_splitCoordinate[0]) ?? null;
                            });
                            _marker.add(Marker(
                              markerId: MarkerId(
                                state.recentEarthquake.infogempa.gempa.tanggal,
                              ),
                              position: LatLng(lat, lng),
                              infoWindow: InfoWindow(
                                title: state
                                    .recentEarthquake.infogempa.gempa.potensi,
                              ),
                              icon: BitmapDescriptor.defaultMarker,
                            ));
                          }
                        },
                      ),
                      BlocListener<eh.EarthquakeHistoryBloc,
                          eh.EarthquakeHistoryState>(
                        listener: (context, eh.EarthquakeHistoryState state) {
                          if (state is eh.LoadedState) {
                            for (var i = 0;
                                i <
                                    state.earthquakeHistory.infogempa.gempa
                                        .length;
                                i++) {
                              var item =
                                  state.earthquakeHistory.infogempa.gempa[i];
                              _historyCoordinate = item.point.coordinates;
                              _splitHistoryCoordinate =
                                  _historyCoordinate.split(',');
                              histroyLat =
                                  double.tryParse(_splitHistoryCoordinate[1]) ??
                                      null;
                              historyLng =
                                  double.tryParse(_splitHistoryCoordinate[0]) ??
                                      null;
                              _historyMarker.add(Marker(
                                markerId: MarkerId(item.jam),
                                position: LatLng(histroyLat, historyLng),
                                infoWindow: InfoWindow(
                                  title: item.wilayah,
                                ),
                                onTap: () {
                                  scrollController.jumpTo(index: i);
                                },
                                icon: BitmapDescriptor.defaultMarker,
                              ));
                              _splitHistoryCoordinate.clear();
                            }
                          }
                        },
                      ),
                    ],
                    child: _buildRecentEarthquakeBloc(context),
                  ),
                  _buildEarthquakeHistoryBloc(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder _buildRecentEarthquakeBloc(BuildContext context) {
    return BlocBuilder<RecentEarthquakeBloc, RecentEarthquakeState>(
      bloc: recentEarthquakeBloc,
      builder: (context, RecentEarthquakeState state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedState) {
          return _buildRecentEarthquakeLoadedState(state);
        } else if (state is ErrorState) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildRecentEarthquakeLoadedState(LoadedState state) {
    return RecentEarthquake(
      state: state,
    );
  }

  BlocBuilder _buildEarthquakeHistoryBloc(BuildContext context) {
    return BlocBuilder<eh.EarthquakeHistoryBloc, eh.EarthquakeHistoryState>(
      bloc: earthquakeHistoryBloc,
      builder: (context, eh.EarthquakeHistoryState state) {
        if (state is eh.LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is eh.LoadedState) {
          return _buildEarhtquakeHistoryLoadedState(state);
        } else if (state is eh.ErrorState) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildEarhtquakeHistoryLoadedState(eh.LoadedState state) {
    return EarthquakeHistory(
      state: state,
      scrollController: scrollController,
      mapController: _mapController,
    );
  }
}
