# POI 搜索 + 详情功能实现计划

## Context

在现有地图应用中添加 POI（兴趣点）搜索和详情查看功能。用户可以搜索周边兴趣点（如餐厅、酒店、加油站等），点击查看 POI 详细信息。

**技术选型**：Google Places API（项目已使用 google_maps_flutter）

---

## 实现方案

### 1. 数据模型

新建 `lib/models/poi.dart`：

- `PoiCategory` 枚举（餐饮/酒店/加油站/银行/购物/医院/学校/景点）
- `Poi` 数据类（id/name/address/LatLng/category/phone/rating/photoUrl）

### 2. POI 服务

新建 `lib/services/poi_service.dart`：

- 封装 Google Places API（Nearby Search + Text Search + Details）
- 使用现有 `Dio` HTTP 客户端

新建 `lib/services/api_keys.dart`：

- 管理 Google Maps API Key 配置

### 3. UI 组件

| 组件 | 文件 | 说明 |
|------|------|------|
| POI分类选择栏 | `lib/widgets/poi_category_bar.dart` | 横向滚动分类快捷选择 |
| POI搜索面板 | `lib/widgets/poi_search_panel.dart` | 搜索框+分类栏+结果列表 |
| POI搜索结果项 | `lib/widgets/poi_search_result_item.dart` | 单条POI结果展示 |
| POI详情底页 | `lib/widgets/poi_detail_sheet.dart` | BottomSheet 展示POI详情 |

### 4. 地图集成

修改 `lib/map.dart`：

- 添加 POI 搜索面板展开/收起逻辑
- 在地图上显示 POI 标记（蓝色，区别于门店红色/黄色）
- 点击 POI 标记弹出详情 BottomSheet

修改 `lib/widgets/map_toolbar.dart`：

- 搜索按钮触发 POI 搜索面板展开

---

## 关键文件

| 操作 | 文件路径 |
|------|----------|
| 新建 | `lib/models/poi.dart` |
| 新建 | `lib/services/poi_service.dart` |
| 新建 | `lib/services/api_keys.dart` |
| 新建 | `lib/widgets/poi_category_bar.dart` |
| 新建 | `lib/widgets/poi_search_panel.dart` |
| 新建 | `lib/widgets/poi_search_result_item.dart` |
| 新建 | `lib/widgets/poi_detail_sheet.dart` |
| 修改 | `lib/map.dart` |
| 修改 | `lib/widgets/map_toolbar.dart` |

**参考文件**（复用现有代码）：

- `lib/models/store.dart` - POI 模型设计参考
- `lib/widgets/search_bar_widget.dart` - 搜索组件参考
- `lib/widgets/store_info_window.dart` - 详情卡片样式参考

---

## Google Places API 使用

### API Endpoint

```
https://maps.googleapis.com/maps/api/place/
```

### 需要启用的 API

1. **Places API** - POI 搜索和详情
2. **Geocoding API** - 地址解析（如需要）

### API Key 配置

在 `lib/services/api_keys.dart` 中管理，用户需提供 Google Maps API Key 并确保在 Google Cloud Console 启用了 Places API。

---

## 分步实施

### 阶段一：数据模型和服务

1. 创建 `lib/models/poi.dart`
2. 创建 `lib/services/api_keys.dart`
3. 创建 `lib/services/poi_service.dart`

### 阶段二：UI 组件

4. 创建 `lib/widgets/poi_category_bar.dart`
5. 创建 `lib/widgets/poi_search_result_item.dart`
6. 创建 `lib/widgets/poi_search_panel.dart`
7. 创建 `lib/widgets/poi_detail_sheet.dart`

### 阶段三：地图集成

8. 修改 `lib/widgets/map_toolbar.dart` 支持搜索面板展开
9. 修改 `lib/map.dart` 集成 POI 搜索流程和标记显示

---

## 验证方式

1. **POI 搜索**：在搜索框输入"restaurant"，底部列表展示 POI 结果
2. **分类搜索**：点击"餐饮"分类，搜索周边餐饮 POI
3. **地图标记**：点击 POI 列表项，地图上出现蓝色 POI 标记并自动聚焦
4. **详情查看**：点击地图 POI 标记，弹出 BottomSheet 显示 POI 详情（名称/地址/电话/评分）
5. **清除操作**：点击清除按钮，POI 标记和搜索面板消失，恢复普通地图模式
