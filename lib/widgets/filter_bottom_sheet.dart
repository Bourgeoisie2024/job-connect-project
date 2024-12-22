import 'package:flutter/material.dart';
import 'package:job_connect/theme/app_theme.dart';

class JobFilter {
  final List<String> jobTypes;
  final String? location;
  final double? minSalary;
  final double? maxSalary;

  JobFilter({
    required this.jobTypes,
    this.location,
    this.minSalary,
    this.maxSalary,
  });
}

class FilterBottomSheet extends StatefulWidget {
  final JobFilter initialFilter;
  final Function(JobFilter) onApply;

  const FilterBottomSheet({
    super.key,
    required this.initialFilter,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late List<String> _selectedJobTypes;
  late TextEditingController _locationController;
  late RangeValues _salaryRange;

  @override
  void initState() {
    super.initState();
    _selectedJobTypes = List.from(widget.initialFilter.jobTypes);
    _locationController =
        TextEditingController(text: widget.initialFilter.location);
    _salaryRange = RangeValues(
      widget.initialFilter.minSalary ?? 0,
      widget.initialFilter.maxSalary ?? 200000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Filter Jobs',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          Text(
            'Job Type',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildFilterChip('Full-time'),
              _buildFilterChip('Part-time'),
              _buildFilterChip('Contract'),
              _buildFilterChip('Remote'),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Location',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              hintText: 'Enter location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Salary Range',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          RangeSlider(
            values: _salaryRange,
            min: 0,
            max: 200000,
            divisions: 20,
            labels: RangeLabels(
              '\$${_salaryRange.start.round()}',
              '\$${_salaryRange.end.round()}',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _salaryRange = values;
              });
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              widget.onApply(JobFilter(
                jobTypes: _selectedJobTypes,
                location: _locationController.text,
                minSalary: _salaryRange.start,
                maxSalary: _salaryRange.end,
              ));
              Navigator.pop(context);
            },
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedJobTypes.contains(label);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedJobTypes.add(label);
          } else {
            _selectedJobTypes.remove(label);
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
