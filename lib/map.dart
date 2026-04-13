import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/store.dart';
import 'services/location_service.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/filter_panel.dart';
import 'widgets/map_toolbar.dart';
import 'widgets/store_info_window.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const CameraPosition _defaultPosition = CameraPosition(
    target: LatLng(31.2304, 121.4737),
    zoom: 10,
  );

  GoogleMapController? _mapController;
  Set<Marker> _cachedMarkers = {};
  List<Store> _filteredStores = MockStores.stores;

  // 搜索和筛选状态
  String _searchKeyword = '';
  List<StoreType> _selectedTypes = [];
  List<StoreStatus> _selectedStatuses = [];

  // 选中门店
  Store? _selectedStore;
  Set<Store> _selectedStoresForBatch = {};

  // 画选模式
  bool _isDrawMode = false;
  LatLng? _drawStartPoint;
  LatLng? _drawEndPoint;

  // 筛选面板
  bool _showFilterPanel = false;

  // 批量操作
  bool _showBatchPanel = false;

  // 加载状态
  bool _isLocating = false;

  @override
  void initState() {
    super.initState();
    _buildMarkersCache();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _moveToCurrentLocation();
  }

  Future<void> _moveToCurrentLocation() async {
    setState(() => _isLocating = true);
    final position = await LocationService.getCurrentPosition();
    if (position != null && _mapController != null && mounted) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(position, 14));
    }
    if (mounted) {
      setState(() => _isLocating = false);
    }
  }

  void _buildMarkersCache() {
    final markers = <Marker>{};
    for (final store in _filteredStores) {
      final isSelected = _selectedStoresForBatch.contains(store);
      final color = _getMarkerColor(store.status, isSelected);
      markers.add(
        Marker(
          markerId: MarkerId(store.id),
          position: store.position,
          icon: BitmapDescriptor.defaultMarkerWithHue(color),
          onTap: () => _onStoreTapped(store),
        ),
      );
    }
    _cachedMarkers = markers;
  }

  double _getMarkerColor(StoreStatus status, bool isSelected) {
    if (isSelected) {
      return BitmapDescriptor.hueAzure;
    }
    switch (status) {
      case StoreStatus.open:
        return BitmapDescriptor.hueGreen;
      case StoreStatus.closed:
        return BitmapDescriptor.hueRed;
      case StoreStatus.pending:
        return BitmapDescriptor.hueYellow;
    }
  }

  void _onStoreTapped(Store store) {
    setState(() {
      _selectedStore = store;
      if (!_isDrawMode) {
        _mapController?.animateCamera(CameraUpdate.newLatLng(store.position));
      }
    });
  }

  void _onSearch(String keyword) {
    _searchKeyword = keyword;
    _applyFilters();
  }

  void _onTypesChanged(List<StoreType> types) {
    _selectedTypes = types;
    _applyFilters();
  }

  void _onStatusesChanged(List<StoreStatus> statuses) {
    _selectedStatuses = statuses;
    _applyFilters();
  }

  void _applyFilters() {
    var result = MockStores.stores;

    // 搜索过滤
    if (_searchKeyword.isNotEmpty) {
      result = MockStores.search(_searchKeyword);
    }

    // 类型过滤
    if (_selectedTypes.isNotEmpty) {
      result = result.where((s) => _selectedTypes.contains(s.type)).toList();
    }

    // 状态过滤
    if (_selectedStatuses.isNotEmpty) {
      result = result.where((s) => _selectedStatuses.contains(s.status)).toList();
    }

    _filteredStores = result;
    _buildMarkersCache();
    setState(() {});
  }

  Future<void> _onLocate() async {
    final position = await LocationService.getCurrentPosition();
    if (position != null && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('无法获取位置，请检查定位权限')));
      }
    }
  }

  void _toggleDrawMode() {
    setState(() {
      _isDrawMode = !_isDrawMode;
      if (!_isDrawMode) {
        _drawStartPoint = null;
        _drawEndPoint = null;
        _selectedStoresForBatch.clear();
        _showBatchPanel = false;
        _buildMarkersCache();
      }
    });
  }

  void _onMapTap(LatLng position) {
    if (_isDrawMode) {
      if (_drawStartPoint == null) {
        setState(() {
          _drawStartPoint = position;
          _drawEndPoint = position;
        });
      } else {
        setState(() {
          _drawEndPoint = position;
        });
        _updateSelectedStoresInRect();
      }
    } else {
      setState(() {
        _selectedStore = null;
      });
    }
  }

  void _updateSelectedStoresInRect() {
    if (_drawStartPoint == null || _drawEndPoint == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        _drawStartPoint!.latitude < _drawEndPoint!.latitude
            ? _drawStartPoint!.latitude
            : _drawEndPoint!.latitude,
        _drawStartPoint!.longitude < _drawEndPoint!.longitude
            ? _drawStartPoint!.longitude
            : _drawEndPoint!.longitude,
      ),
      northeast: LatLng(
        _drawStartPoint!.latitude > _drawEndPoint!.latitude
            ? _drawStartPoint!.latitude
            : _drawEndPoint!.latitude,
        _drawStartPoint!.longitude > _drawEndPoint!.longitude
            ? _drawStartPoint!.longitude
            : _drawEndPoint!.longitude,
      ),
    );

    final selected = _filteredStores.where((store) {
      return LocationService.isPointInRect(store.position, bounds);
    }).toSet();

    _selectedStoresForBatch = selected;
    _showBatchPanel = selected.isNotEmpty;
    _buildMarkersCache();
    setState(() {});
  }

  void _clearSelection() {
    _selectedStoresForBatch.clear();
    _drawStartPoint = null;
    _drawEndPoint = null;
    _showBatchPanel = false;
    _buildMarkersCache();
    setState(() {});
  }

  void _executeBatchOperation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已选中 ${_selectedStoresForBatch.length} 个门店')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 地图
          GoogleMap(
            initialCameraPosition: _defaultPosition,
            onMapCreated: _onMapCreated,
            markers: _cachedMarkers,
            onTap: _onMapTap,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
          ),

          // 定位加载指示器
          if (_isLocating)
            const Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('正在定位...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // 画选矩形
          if (_isDrawMode && _drawStartPoint != null && _drawEndPoint != null)
            _buildDrawOverlay(),

          // 搜索栏
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            right: 0,
            child: SearchBarWidget(
              onSearch: _onSearch,
              onFilterTap: () {
                setState(() {
                  _showFilterPanel = !_showFilterPanel;
                });
              },
            ),
          ),

          // 筛选面板
          if (_showFilterPanel)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              right: 0,
              bottom: 0,
              child: FilterPanel(
                selectedTypes: _selectedTypes,
                selectedStatuses: _selectedStatuses,
                onTypesChanged: _onTypesChanged,
                onStatusesChanged: _onStatusesChanged,
                onClose: () {
                  setState(() {
                    _showFilterPanel = false;
                  });
                },
              ),
            ),

          // 工具栏
          Positioned(
            right: 16,
            bottom: _showBatchPanel ? 120 : 80,
            child: MapToolbar(
              onSearch: () {
                _onSearch(_searchKeyword);
              },
              onLocate: _onLocate,
              onDrawSelect: _toggleDrawMode,
              isDrawMode: _isDrawMode,
            ),
          ),

          // 门店详情浮窗
          if (_selectedStore != null && !_isDrawMode)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: StoreInfoWindow(
                  store: _selectedStore!,
                  onViewDetails: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('查看门店: ${_selectedStore!.name}')),
                    );
                  },
                  onCreateTask: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('为门店: ${_selectedStore!.name} 创建任务'),
                      ),
                    );
                  },
                  onClose: () {
                    setState(() {
                      _selectedStore = null;
                    });
                  },
                ),
              ),
            ),

          // 批量操作面板
          if (_showBatchPanel)
            Positioned(left: 0, right: 0, bottom: 0, child: _buildBatchPanel()),
        ],
      ),
    );
  }

  Widget _buildDrawOverlay() {
    return CustomPaint(
      size: Size.infinite,
      painter: _DrawSelectionPainter(
        start: _drawStartPoint!,
        end: _drawEndPoint!,
        mapController: _mapController!,
      ),
    );
  }

  Widget _buildBatchPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _clearSelection,
            ),
            const SizedBox(width: 8),
            Text(
              '已选 ${_selectedStoresForBatch.length} 个门店',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _executeBatchOperation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('执行操作'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawSelectionPainter extends CustomPainter {
  final LatLng start;
  final LatLng end;
  final GoogleMapController mapController;

  _DrawSelectionPainter({
    required this.start,
    required this.end,
    required this.mapController,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final screenStart = _latLngToScreenPoint(start);
    final screenEnd = _latLngToScreenPoint(end);

    if (screenStart == null || screenEnd == null) return;

    final rect = Rect.fromPoints(screenStart, screenEnd);

    // 填充
    final fillPaint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, fillPaint);

    // 边框
    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(rect, borderPaint);
  }

  Offset? _latLngToScreenPoint(LatLng latLng) {
    // 获取屏幕坐标的简化实现
    // 实际项目中需要使用 mapController.getProjection()
    return null;
  }

  @override
  bool shouldRepaint(covariant _DrawSelectionPainter oldDelegate) {
    return start != oldDelegate.start || end != oldDelegate.end;
  }
}
