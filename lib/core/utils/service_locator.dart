import 'package:bookly_app/core/utils/api_service.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_implementation.dart';
import 'package:bookly_app/features/search/data/repos/search_repo_implementation.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  BaseOptions options = BaseOptions(
    baseUrl: ApiService.baseURL,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(minutes: 1), // 60 seconds
    receiveTimeout: const Duration(minutes: 1), // 60 seconds
  );
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(options),
    ),
  );
  getIt.registerSingleton<HomeRepoImplementation>(
    HomeRepoImplementation(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<SearchRepoImplementation>(
    SearchRepoImplementation(getIt.get<ApiService>()),
  );
}
