import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/store.dart';
import 'utils/geometry_utils.dart';
import 'widgets/map_toolbar.dart';

enum _MapMode { normal, drawing }

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const _initialPosition = CameraPosition(
    target: LatLng(22.55329, 113.88308),
    zoom: 14,
  );

  final _mapKey = GlobalKey();
  GoogleMapController? _controller;
  _MapMode _mode = _MapMode.normal;
  List<LatLng> _drawPath = [];
  Set<Polyline> _drawLine = {};
  Set<Polygon> _drawPolygons = {};
  Set<String> _selectedIds = {};
  String _drawHint = '';
  Set<Marker> _markers = {};
  int _lastDrawMs = 0;

  @override
  void initState() {
    super.initState();
    _markers = _buildMarkers();
  }

  Set<Marker> _buildMarkers() {
    return MockStores.stores.map((store) {
      final isSelected = _selectedIds.contains(store.id);
      return Marker(
        markerId: MarkerId(store.id),
        position: store.position,
        icon: isSelected
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: store.name, snippet: store.address),
      );
    }).toSet();
  }

  List<Store> get _selectedStores =>
      MockStores.stores.where((s) => _selectedIds.contains(s.id)).toList();

  void _onMapCreated(GoogleMapController c) => _controller = c;

  /// Android 的 Google Maps SDK 需要物理像素，iOS 使用逻辑像素。
  Future<LatLng?> _screenToLatLng(Offset globalPosition) async {
    if (_controller == null) return null;
    final renderBox = _mapKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;
    final local = renderBox.globalToLocal(globalPosition);
    final ratio = Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    return _controller!.getLatLng(ScreenCoordinate(
      x: (local.dx * ratio).round(),
      y: (local.dy * ratio).round(),
    ));
  }

  void _onPointerDown(PointerDownEvent e) async {
    final pt = await _screenToLatLng(e.position);
    if (pt == null || !mounted) return;
    setState(() {
      _drawPath = [pt];
      _drawLine = {};
      _drawPolygons = {};
      _selectedIds = {};
      _markers = _buildMarkers();
      _drawHint = '';
    });
  }

  void _onPointerMove(PointerMoveEvent e) async {
    final pt = await _screenToLatLng(e.position);
    if (pt == null || !mounted) return;
    _drawPath.add(pt);

    // 节流：最多 ~30fps 更新 UI，但始终记录所有轨迹点
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastDrawMs < 33) return;
    _lastDrawMs = now;

    setState(() {
      _drawLine = {
        Polyline(
          polylineId: const PolylineId('draw'),
          points: _drawPath,
          color: Colors.blue,
          width: 3,
        ),
      };
    });
  }

  void _onDrawEnd() {
    if (_drawPath.length < 3) {
      setState(() {
        _drawHint = '轨迹点太少，请重新绘制';
        _drawLine = {};
        _drawPolygons = {};
      });
      return;
    }

    final closed = GeometryUtils.closePath(_drawPath);
    final simplified = GeometryUtils.douglasPeucker(closed, 0.00005);

    final selected = <String>{};
    for (final store in MockStores.stores) {
      if (GeometryUtils.isPointInPolygon(store.position, simplified)) {
        selected.add(store.id);
      }
    }

    setState(() {
      _selectedIds = selected;
      _markers = _buildMarkers();
      _drawLine = {};
      _drawPolygons = {
        Polygon(
          polygonId: const PolygonId('draw'),
          points: simplified,
          fillColor: Colors.blue.withValues(alpha: 0.3),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      };
      _drawHint = '';
    });
  }

  void _toggleMode() {
    setState(() {
      _mode = _mode == _MapMode.drawing ? _MapMode.normal : _MapMode.drawing;
      _drawPath = [];
      _drawLine = {};
      _drawPolygons = {};
      _selectedIds = {};
      _markers = _buildMarkers();
      _drawHint = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            key: _mapKey,
            initialCameraPosition: _initialPosition,
            onMapCreated: _onMapCreated,
            markers: _markers,
            polylines: _drawLine,
            polygons: _drawPolygons,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            scrollGesturesEnabled: _mode != _MapMode.drawing,
            zoomGesturesEnabled: _mode != _MapMode.drawing,
            rotateGesturesEnabled: _mode != _MapMode.drawing,
            tiltGesturesEnabled: _mode != _MapMode.drawing,
          ),
          if (_mode == _MapMode.drawing)
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.opaque,
                onPointerDown: _onPointerDown,
                onPointerMove: _onPointerMove,
                onPointerUp: (_) => _onDrawEnd(),
                child: const SizedBox.expand(),
              ),
            ),
          if (_mode == _MapMode.drawing && _drawHint.isNotEmpty)
            Positioned(
              top: 60,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_drawHint, style: TextStyle(color: Colors.orange.shade900)),
              ),
            ),
          Positioned(
            right: 12,
            top: 80,
            child: MapToolbar(
              onSearch: () {},
              onLocate: () {},
              onDrawSelect: _toggleMode,
              isDrawMode: _mode == _MapMode.drawing,
            ),
          ),
          if (_selectedIds.isNotEmpty)
            _SelectedStoresPanel(
              stores: _selectedStores,
              onClear: () => setState(() {
                _selectedIds = {};
                _markers = _buildMarkers();
                _drawLine = {};
                _drawPolygons = {};
                _mode = _MapMode.normal;
              }),
            ),
        ],
      ),
    );
  }
}

class _SelectedStoresPanel extends StatelessWidget {
  final List<Store> stores;
  final VoidCallback onClear;

  const _SelectedStoresPanel({required this.stores, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 260),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -2))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('已选中 ${stores.length} 家门店',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  TextButton(onPressed: onClear, child: const Text('清除')),
                ],
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: stores.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final s = stores[i];
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(s.name, style: const TextStyle(fontSize: 14)),
                    subtitle: Text(s.address, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(Store.typeName(s.type),
                          style: TextStyle(fontSize: 11, color: Colors.blue[700])),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
