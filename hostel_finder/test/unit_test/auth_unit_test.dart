import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';
import 'package:hive_and_api_for_class/features/auth/domain/use_case/auth_usecase.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_unit_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    mockAuthUsecase = MockAuthUseCase();
    context = MockBuildContext();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockAuthUsecase),
        ),
      ],
    );
  });

  test('check for the inital state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);







  });

  // While testing this for now comment the navigation part and snackbar part
  test('login test with valid username and', () async {
    when(mockAuthUsecase.loginStudent('Manoj', 'Manoj123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    when(mockAuthUsecase.loginStudent('Manoj', 'Manoj1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .loginStudent(context, 'Manoj', 'Manoj1234');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });

  test('check for invalid username and password ', () async {
    when(mockAuthUsecase.loginStudent('Manoj', 'Manoj1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .loginStudent(context, 'Manoj', 'Manoj1234');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid');
  });

  tearDownAll(
    () => container.dispose(),
  );
}
