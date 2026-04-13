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
      name: '北京朝阳旗舰店',
      address: '北京市朝阳区建国路88号',
      position: const LatLng(39.9042, 116.4074),
      type: StoreType.directSales,
      status: StoreStatus.open,
      phone: '010-12345678',
    ),
    Store(
      id: '2',
      name: '上海浦东店',
      address: '上海市浦东新区世纪大道100号',
      position: const LatLng(31.2304, 121.4737),
      type: StoreType.directSales,
      status: StoreStatus.open,
      phone: '021-87654321',
    ),
    Store(
      id: '3',
      name: '广州天河店',
      address: '广州市天河区天河路123号',
      position: const LatLng(23.1291, 113.2644),
      type: StoreType.franchise,
      status: StoreStatus.open,
      phone: '020-11112222',
    ),
    Store(
      id: '4',
      name: '深圳南山店',
      address: '深圳市南山区科技园南区',
      position: const LatLng(22.5431, 113.9533),
      type: StoreType.outlet,
      status: StoreStatus.closed,
      phone: '0755-33334444',
    ),
    Store(
      id: '5',
      name: '杭州西湖店',
      address: '杭州市西湖区湖滨路1号',
      position: const LatLng(30.2489, 120.1488),
      type: StoreType.directSales,
      status: StoreStatus.pending,
      phone: '0571-55556666',
    ),
    Store(
      id: '6',
      name: '成都锦江店',
      address: '成都市锦江区春熙路100号',
      position: const LatLng(30.6587, 104.0658),
      type: StoreType.franchise,
      status: StoreStatus.open,
      phone: '028-77778888',
    ),
    Store(
      id: '7',
      name: '武汉武昌店',
      address: '武汉市武昌区中南路7号',
      position: const LatLng(30.5355, 114.3667),
      type: StoreType.directSales,
      status: StoreStatus.open,
      phone: '027-99990000',
    ),
    Store(
      id: '8',
      name: '西安雁塔店',
      address: '西安市雁塔区小寨路50号',
      position: const LatLng(34.2257, 108.9585),
      type: StoreType.outlet,
      status: StoreStatus.closed,
      phone: '029-11113333',
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