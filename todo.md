# 待办事项

## 进行中

## 已完成

- [x] 固定地图初始位置经纬度为 (113.88308, 22.55329)

## 计划中

### 地图圈选门店功能

**功能描述：** 用户在地图上通过交互划一个区域（圆形/多边形/手绘），自动选中圈中的所有门店并高亮显示

#### 方案一：圆形圈选

- **核心思路：** 用户长按设置圆心，拖动设置半径，Haversine 公式判断门店是否在圆内
- **新增文件：**
  - `lib/components/mapPage/circle_selection_controller.dart`
  - `lib/components/mapPage/selection_mode_bar.dart`
  - `lib/utils/geometry_utils.dart`
- **修改文件：** `lib/pages/map/map_page.dart`
- **优点：** 实现简单，交互直观，Haversine 已有实现
- **缺点：** 仅支持圆形，无法贴合不规则区域

#### 方案二：多边形圈选

- **核心思路：** 用户点击添加顶点形成封闭多边形，射线法判断门店是否在多边形内
- **新增文件：**
  - `lib/components/mapPage/polygon_selection_controller.dart`
  - `lib/utils/geometry_utils.dart`
- **修改文件：** `lib/pages/map/map_page.dart`
- **优点：** 支持任意形状区域，精确选择
- **缺点：** 实现复杂度较高

#### 方案三：自由手绘圈选

- **核心思路：** 用户手指滑动绘制任意形状轨迹，Douglas-Peucker 简化轨迹，射线法判断门店是否在区域内
- **新增文件：**
  - `lib/components/mapPage/freehand_selection_controller.dart`
  - `lib/utils/geometry_utils.dart`
- **修改文件：** `lib/pages/map/map_page.dart`
- **优点：** 最灵活，用户可绘制任意形状，交互直观
- **缺点：** 实现复杂度最高，需要简化算法处理大量轨迹点

#### 关键文件

- `lib/pages/map/map_page.dart` - 地图页面主文件
- `lib/viewmodels/store_model.dart` - NearbyStore 含 latitude/longitude
- `lib/utils/map_utils.dart` - 已有 `calculateDistance()` Haversine 实现
