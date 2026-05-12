import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeometryUtils {
  /// Douglas-Peucker 算法：简化轨迹点。
  /// [points] 原始点列表，[epsilon] 简化容差（经纬度单位，约 0.0001 ≈ 10m）。
  static List<LatLng> douglasPeucker(List<LatLng> points, double epsilon) {
    if (points.length < 3) return List.from(points);

    double dmax = 0;
    int index = 0;
    final end = points.length - 1;

    for (int i = 1; i < end; i++) {
      final d = _perpendicularDistance(points[i], points.first, points.last);
      if (d > dmax) {
        dmax = d;
        index = i;
      }
    }

    if (dmax > epsilon) {
      final left = douglasPeucker(points.sublist(0, index + 1), epsilon);
      final right = douglasPeucker(points.sublist(index), epsilon);
      return [...left.take(left.length - 1), ...right];
    }

    return [points.first, points.last];
  }

  /// 点到线段 AB 的垂直距离（经纬度近似笛卡尔）。
  static double _perpendicularDistance(LatLng p, LatLng a, LatLng b) {
    final dx = b.longitude - a.longitude;
    final dy = b.latitude - a.latitude;
    if (dx == 0 && dy == 0) {
      return sqrt(pow(p.longitude - a.longitude, 2) + pow(p.latitude - a.latitude, 2));
    }
    final t = ((p.longitude - a.longitude) * dx + (p.latitude - a.latitude) * dy) / (dx * dx + dy * dy);
    final projLng = a.longitude + t * dx;
    final projLat = a.latitude + t * dy;
    return sqrt(pow(p.longitude - projLng, 2) + pow(p.latitude - projLat, 2));
  }

  /// 射线法：判断点是否在多边形内部。
  /// 从 point 向右发射水平射线，统计与 polygon 各边的交点数。
  /// 奇数 → 内部，偶数 → 外部。
  static bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
    if (polygon.length < 3) return false;

    int count = 0;
    final n = polygon.length;
    final px = point.longitude;
    final py = point.latitude;

    for (int i = 0; i < n; i++) {
      final a = polygon[i];
      final b = polygon[(i + 1) % n];

      final ax = a.longitude;
      final ay = a.latitude;
      final bx = b.longitude;
      final by = b.latitude;

      // 检查射线是否与边相交
      if ((ay > py) != (by > py)) {
        final intersectX = ax + (py - ay) * (bx - ax) / (by - ay);
        if (px < intersectX) {
          count++;
        }
      }
    }

    return count % 2 == 1;
  }

  /// 生成多边形闭合路径（首尾相连）。
  static List<LatLng> closePath(List<LatLng> points) {
    if (points.isEmpty) return points;
    if (points.length < 3) return points;
    final result = List<LatLng>.from(points);
    if (result.first != result.last) {
      result.add(result.first);
    }
    return result;
  }
}
