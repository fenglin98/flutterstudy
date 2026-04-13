import 'package:flutter/material.dart';

class MapToolbar extends StatelessWidget {
  final VoidCallback onSearch;
  final VoidCallback onLocate;
  final VoidCallback onDrawSelect;
  final bool isDrawMode;

  const MapToolbar({
    super.key,
    required this.onSearch,
    required this.onLocate,
    required this.onDrawSelect,
    this.isDrawMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ToolbarButton(
          icon: Icons.search,
          tooltip: '搜索',
          onTap: onSearch,
        ),
        const SizedBox(height: 8),
        _ToolbarButton(
          icon: Icons.my_location,
          tooltip: '定位',
          onTap: onLocate,
        ),
        const SizedBox(height: 8),
        _ToolbarButton(
          icon: isDrawMode ? Icons.cancel : Icons.edit,
          tooltip: isDrawMode ? '取消画选' : '画选门店',
          onTap: onDrawSelect,
          isActive: isDrawMode,
        ),
      ],
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isActive;

  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue[600] : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : Colors.grey[700],
            size: 24,
          ),
        ),
      ),
    );
  }
}