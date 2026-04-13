import 'package:flutter/material.dart';
import '../models/store.dart';

class FilterPanel extends StatefulWidget {
  final List<StoreType> selectedTypes;
  final List<StoreStatus> selectedStatuses;
  final ValueChanged<List<StoreType>> onTypesChanged;
  final ValueChanged<List<StoreStatus>> onStatusesChanged;
  final VoidCallback onClose;

  const FilterPanel({
    super.key,
    required this.selectedTypes,
    required this.selectedStatuses,
    required this.onTypesChanged,
    required this.onStatusesChanged,
    required this.onClose,
  });

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  late List<StoreType> _selectedTypes;
  late List<StoreStatus> _selectedStatuses;

  @override
  void initState() {
    super.initState();
    _selectedTypes = List.from(widget.selectedTypes);
    _selectedStatuses = List.from(widget.selectedStatuses);
  }

  void _toggleType(StoreType type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  void _toggleStatus(StoreStatus status) {
    setState(() {
      if (_selectedStatuses.contains(status)) {
        _selectedStatuses.remove(status);
      } else {
        _selectedStatuses.add(status);
      }
    });
  }

  void _apply() {
    widget.onTypesChanged(_selectedTypes);
    widget.onStatusesChanged(_selectedStatuses);
    widget.onClose();
  }

  void _reset() {
    setState(() {
      _selectedTypes.clear();
      _selectedStatuses.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[600],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '筛选',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: widget.onClose,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '门店类型',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: StoreType.values.map((type) {
                      final isSelected = _selectedTypes.contains(type);
                      return GestureDetector(
                        onTap: () => _toggleType(type),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue[600] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            Store.typeName(type),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '营业状态',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: StoreStatus.values.map((status) {
                      final isSelected = _selectedStatuses.contains(status);
                      return GestureDetector(
                        onTap: () => _toggleStatus(status),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue[600] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            Store.statusName(status),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    child: const Text('重置'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _apply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('应用'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}