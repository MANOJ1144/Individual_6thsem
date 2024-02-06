import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_and_api_for_class/config/router/app_route.dart';
import 'package:hive_and_api_for_class/features/auth/domain/use_case/auth_usecase.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:hive_and_api_for_class/features/batch/domain/entity/batch_entity.dart';
import 'package:hive_and_api_for_class/features/batch/domain/use_case/batch_use_case.dart';
import 'package:hive_and_api_for_class/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:hive_and_api_for_class/features/course/domain/entity/course_entity.dart';
import 'package:hive_and_api_for_class/features/course/domain/use_case/course_usecase.dart';
import 'package:hive_and_api_for_class/features/course/presentation/viewmodel/course_viewmodel.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test/features/auth/presentation/view/login_view_test.mocks.dart';
import '../test/features/auth/presentation/view/register_view_test.mocks.dart';
import '../test_data/batch_entity_test.dart';
import '../test_data/course_entity_test.dart';

@GenerateNiceMocks([
  MockSpec<BatchUseCase>(),
  MockSpec<CourseUseCase>(),
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late BatchUseCase mockBatchUsecase;
  late CourseUseCase mockCourseUsecase;
  // We are doing these for dashboard
  late List<BatchEntity> lstBatchEntity;
  late List<CourseEntity> lstCourseEntity;
  late bool isLogin;

  setUpAll(() async {
    mockAuthUsecase = MockAuthUseCase();
    mockBatchUsecase = MockBatchUseCase();
    mockCourseUsecase = MockCourseUseCase();
    lstBatchEntity = await getBatchListTest();
    lstCourseEntity = await getCourseListTest();

    isLogin = true;
  });

  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {
    when(mockAuthUsecase.loginStudent('kiran', 'kiran123'))
        .thenAnswer((_) async => Right(isLogin));

    when(mockBatchUsecase.getAllBatches())
        .thenAnswer((_) async => Right(lstBatchEntity));

    when(mockCourseUsecase.getAllCourses())
        .thenAnswer((_) async => Right(lstCourseEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
          batchViewModelProvider
              .overrideWith((ref) => BatchViewModel(mockBatchUsecase)),
          courseViewModelProvider
              .overrideWith((ref) => CourseViewModel(mockCourseUsecase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Type in first textformfield/TextField
    await tester.enterText(find.byType(TextField).at(0), 'kiran');
    // Type in second textformfield
    await tester.enterText(find.byType(TextField).at(1), 'kiran123');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Login'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Dashboard View'), findsOneWidget);
  });
}
