import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';
import 'package:hive_and_api_for_class/features/batch/domain/entity/batch_entity.dart';
import 'package:hive_and_api_for_class/features/batch/domain/use_case/batch_use_case.dart';
import 'package:hive_and_api_for_class/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/batch_entity_test.dart';
import 'batch_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<BatchUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late BatchUseCase mockBatchUsecase;
  late List<BatchEntity> batchEntity;

  setUpAll(() async {
    mockBatchUsecase = MockBatchUseCase();
    batchEntity = await getBatchListTest();
    when(mockBatchUsecase.getAllBatches())
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(
      overrides: [
        batchViewModelProvider.overrideWith(
          (ref) => BatchViewModel(mockBatchUsecase),
        ),
      ],
    );
  });

  test('check batch initial state', () async {
    await container.read(batchViewModelProvider.notifier).getAllBatches();

    final batchState = container.read(batchViewModelProvider);

    expect(batchState.isLoading, false);
    expect(batchState.batches, isEmpty);
    expect(batchState.students, isEmpty);
  });

  test('check for the list of batches when calling getAllBatches', () async {
    when(mockBatchUsecase.getAllBatches())
        .thenAnswer((_) => Future.value(Right(batchEntity)));

    await container.read(batchViewModelProvider.notifier).getAllBatches();

    final batchState = container.read(batchViewModelProvider);

    expect(batchState.isLoading, false);
    expect(batchState.batches.length, 4);
  });

  test('add batch entity and return true if successfully added', () async {
    when(mockBatchUsecase.addBatch(batchEntity[0]))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(batchViewModelProvider.notifier)
        .addBatch(batchEntity[0]);

    final batchState = container.read(batchViewModelProvider);

    expect(batchState.error, isNull);
  });

  test('add batch entity and return false if an error occured', () async {
    when(mockBatchUsecase.addBatch(batchEntity[0]))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Not added'))));

    await container
        .read(batchViewModelProvider.notifier)
        .addBatch(batchEntity[0]);

    final batchState = container.read(batchViewModelProvider);

    expect(batchState.error, isNotNull);
  });

  tearDownAll(() {
    container.dispose();
  });
}





  // test('check batch state after getAllBatches', () async {
  //   when(mockBatchUsecase.getAllBatches())
  //       .thenAnswer((_) async => Right(batchEntity));
  //   var batchState = container.read(batchViewModelProvider);

  //   batchState = batchState.copyWith(isLoading: false, batches: batchEntity);

  //   List<BatchEntity> batches = await getBatchListTest();
  //   expect(batchState.batches, batches);
  // });