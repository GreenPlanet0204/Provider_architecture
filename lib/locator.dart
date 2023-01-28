import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider_start/core/data_sources/posts/posts_local_data_source.dart';
import 'package:provider_start/core/data_sources/posts/posts_remote_data_source.dart';
import 'package:provider_start/core/data_sources/users/users_local_data_source.dart';
import 'package:provider_start/core/data_sources/users/users_remote_data_source.dart';
import 'package:provider_start/core/services/app_settings/app_settings_service.dart';
import 'package:provider_start/core/services/app_settings/app_settings_service_impl.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/core/services/http/http_service_impl.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository_impl.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository_impl.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/auth/auth_service_impl.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service_impl.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/core/services/dialog/dialog_service_impl.dart';
import 'package:provider_start/core/services/hardware_info/hardware_info_service.dart';
import 'package:provider_start/core/services/hardware_info/hardware_info_service_impl.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service_impl.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service_impl.dart';
import 'package:provider_start/core/services/snackbar/snack_bar_service.dart';
import 'package:provider_start/core/services/snackbar/snack_bar_service_impl.dart';
import 'package:provider_start/core/utils/file_helper.dart';

GetIt locator = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<NavigationService>(
    () => NavigationServiceImpl(),
  );
  locator.registerLazySingleton<HardwareInfoService>(
    () => HardwareInfoServiceImpl(),
  );
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<AppSettingsService>(
    () => AppSettingsServiceImpl(),
  );
  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());
  locator.registerLazySingleton<SnackBarService>(() => SnackBarServiceImpl());
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  // Data sources
  locator.registerLazySingleton<PostsLocalDataSource>(
    () => PostsLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(),
  );
  locator.registerLazySingleton<UsersLocalDataSource>(
    () => UsersLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(),
  );

  // Repositories
  locator.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl());
  locator.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl());

  await _setupSharedPreferences();

  // Utils
  locator.registerLazySingleton<FileHelper>(() => FileHelperImpl());

  // External
  locator.registerLazySingleton<HiveInterface>(() => Hive);
}

Future<void> _setupSharedPreferences() async {
  final instance = await KeyStorageServiceImpl.getInstance();
  locator.registerLazySingleton<KeyStorageService>(() => instance);
}
