import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 门店营业状态
enum StoreStatus {
  open,    // 营业中
  closed,  // 已关闭
  pending, // 筹备中
}

/// 门店类型
enum StoreType {
  directSales,     // 直营店
  franchise,       // 特许经营店
  outlet,          // 折扣店
}

class Store {
  final String id;
  final String name;
  final String address;
  final LatLng position;
  final StoreType type;
  final StoreStatus status;
  final String phone;
  final String? imageUrl;

  const Store({
    required this.id,
    required this.name,
    required this.address,
    required this.position,
    required this.type,
    required this.status,
    required this.phone,
    this.imageUrl,
  });

  Store copyWith({
    String? id,
    String? name,
    String? address,
    LatLng? position,
    StoreType? type,
    StoreStatus? status,
    String? phone,
    String? imageUrl,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      position: position ?? this.position,
      type: type ?? this.type,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  static String typeName(StoreType type) {
    switch (type) {
      case StoreType.directSales:
        return '直营店';
      case StoreType.franchise:
        return '特许经营店';
      case StoreType.outlet:
        return '折扣店';
    }
  }

  static String statusName(StoreStatus status) {
    switch (status) {
      case StoreStatus.open:
        return '营业中';
      case StoreStatus.closed:
        return '已关闭';
      case StoreStatus.pending:
        return '筹备中';
    }
  }
}

/// 模拟门店数据
class MockStores {
  static final List<Store> stores = [
    Store(
      id: '1',
      name: '深圳南山旗舰店',
      address: '深圳市南山区科技园南路88号',
      position: const LatLng(22.5533, 113.8831),
      type: StoreType.directSales,
      status: StoreStatus.open,
      phone: '0755-12345678',
    ),
    Store(
      id: '2',
      name: '深圳海岸城店',
      address: '深圳市南山区文心五路33号',
      position: const LatLng(22.519, 113.938),
      type: StoreType.directSales,
      status: StoreStatus.open,
      phone: '0755-87654321',
    ),
    Store(
      id: '3',
      name: '深圳蛇口港店',
      address: '深圳市南山区蛇口港码头路100号',
      position: const LatLng(22.495, 113.912),
      type: StoreType.franchise,
      status: StoreStatus.open,
      phone: '0755-11112222',
    ),
    Store(
      id: '4',
      name: '深圳西丽店',
      address: '深圳市南山区西丽街道留仙大道200号',
      position: const LatLng(22.579, 113.955),
      type: StoreType.outlet,
      status: StoreStatus.closed,
      phone: '0755-33334444',
    ),
    Store(
      id: '5',
      name: '深圳前海店',
      address: '深圳市南山区前海一路1号',
      position: const LatLng(22.530, 113.895),
      type: StoreType.directSales,
      status: StoreStatus.pending,
      phone: '0755-55556666',
    ),
    Store(
      id: '6',
      name: '深圳宝安中心店',
      address: '深圳市宝安区新安街道创业路50号',
      position: const LatLng(22.561, 113.870),
      type: StoreType.franchise,
      status: StoreStatus.open,
      phone: '0755-77778888',
    ),
    Store(
      id: '7',
      name: '深圳大学城店',
      address: '深圳市南山区学苑大道1088号',
      position: const LatLng(22.592, 113.968),
      type: StoreType.directSales,
      status: StoreStatus.open,
      phone: '0755-99990000',
    ),
    Store(
      id: '8',
      name: '深圳深圳湾店',
      address: '深圳市南山区望海路1177号',
      position: const LatLng(22.508, 113.945),
      type: StoreType.outlet,
      status: StoreStatus.closed,
      phone: '0755-22223333',
    ),
  ];

  static List<Store> search(String keyword) {
    if (keyword.isEmpty) return stores;
    final lower = keyword.toLowerCase();
    return stores.where((s) =>
      s.name.toLowerCase().contains(lower) ||
      s.address.toLowerCase().contains(lower)
    ).toList();
  }

  static List<Store> filter({
    List<StoreType>? types,
    List<StoreStatus>? statuses,
  }) {
    return stores.where((s) {
      if (types != null && types.isNotEmpty && !types.contains(s.type)) {
        return false;
      }
      if (statuses != null && statuses.isNotEmpty && !statuses.contains(s.status)) {
        return false;
      }
      return true;
    }).toList();
  }
}