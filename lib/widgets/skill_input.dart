import 'package:flutter/material.dart';

class SkillInput extends StatefulWidget {
  final List<String> skills;
  final Function(List<String>) onSkillsChanged;

  const SkillInput({
    super.key,
    required this.skills,
    required this.onSkillsChanged,
  });

  @override
  State<SkillInput> createState() => _SkillInputState();
}

class _SkillInputState extends State<SkillInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...widget.skills.map((skill) => Chip(
                  label: Text(skill),
                  onDeleted: () {
                    final updatedSkills = List<String>.from(widget.skills)
                      ..remove(skill);
                    widget.onSkillsChanged(updatedSkills);
                  },
                )),
            Container(
              width: 200,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Add a skill',
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    final updatedSkills = List<String>.from(widget.skills)
                      ..add(value);
                    widget.onSkillsChanged(updatedSkills);
                    _controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
