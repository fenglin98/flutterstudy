import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  /// 检查定位权限
  static Future<bool> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// 获取当前位置
  static Future<LatLng?> getCurrentPosition() async {
    final hasPermission = await checkPermission();
    if (!hasPermission) {
      return null;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return null;
    }
  }

  /// 计算两点之间的距离（米）
  static double distanceBetween(LatLng p1, LatLng p2) {
    return Geolocator.distanceBetween(
      p1.latitude,
      p1.longitude,
      p2.latitude,
      p2.longitude,
    );
  }

  /// 检查点是否在矩形范围内
  static bool isPointInRect(LatLng point, LatLngBounds bounds) {
    return bounds.contains(point);
  }
}