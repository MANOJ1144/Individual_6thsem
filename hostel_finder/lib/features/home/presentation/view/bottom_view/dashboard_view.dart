import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/common/provider/is_dark_theme.dart';
import 'package:hive_and_api_for_class/core/common/snackbar/my_snackbar.dart';
import 'package:hive_and_api_for_class/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:hive_and_api_for_class/features/course/presentation/viewmodel/course_viewmodel.dart';
import 'package:hive_and_api_for_class/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:hive_and_api_for_class/features/home/presentation/widget/batch_widget.dart';

import '../../widget/course_widget.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  late bool isDark;

  @override
  void initState() {
    isDark = ref.read(isDarkThemeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var batchState = ref.watch(batchViewModelProvider);
    var courseState = ref.watch(courseViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png', // Replace with your logo image path
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text('Hostel Finder'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // ref.read(batchViewModelProvider.notifier).getBatches();
              // ref.read(courseViewModelProvider.notifier).getCourses();
              showSnackBar(message: 'Refreshing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          Switch(
            value: isDark,
            onChanged: (value) {
              setState(() {
                isDark = value;
                ref.read(isDarkThemeProvider.notifier).updateTheme(value);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rooms',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: BatchWidget(ref: ref, batchList: batchState.batches),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Block',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: CourseWidget(courseList: courseState.courses),
            ),
            // Add images with descriptions
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showEnlargedImage(
                            'assets/images/Mannat Girls hostel.png');
                      },
                      child: Image.asset(
                        'assets/images/Mannat Girls hostel.png',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Mannat Girls Hostel',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showEnlargedImage('assets/images/hostel.png');
                      },
                      child: Image.asset(
                        'assets/images/hostel.png',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Rajmahal Boys Hostel',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnlargedImage(String imagePath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Image.asset(imagePath),
      ),
    );
  }
}
