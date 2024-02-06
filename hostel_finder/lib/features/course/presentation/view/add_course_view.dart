import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/features/course/presentation/viewmodel/course_viewmodel.dart';

import '../widget/load_course.dart';

class AddCourseView extends ConsumerStatefulWidget {
  const AddCourseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCourseViewState();
}

class _AddCourseViewState extends ConsumerState<AddCourseView> {
  final courseController = TextEditingController();
  var gap = const SizedBox(height: 8);
  @override
  Widget build(BuildContext context) {
    var courseState = ref.watch(courseViewModelProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Add Block',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            TextFormField(
              controller: courseController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Block Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter block name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Add Block'),
              ),
            ),
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'List of Blocks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            if (courseState.isLoading) ...{
              const CircularProgressIndicator(),
            } else if (courseState.error != null) ...{
              Text(courseState.error!),
            } else if (courseState.courses.isNotEmpty) ...{
              Expanded(
                child: LoadCourse(
                  lstCourse: courseState.courses,
                  ref: ref,
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}
