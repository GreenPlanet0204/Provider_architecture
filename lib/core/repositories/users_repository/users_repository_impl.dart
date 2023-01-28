import 'package:logging/logging.dart';
import 'package:provider_start/core/data_sources/users/users_local_data_source.dart';
import 'package:provider_start/core/data_sources/users/users_remote_data_source.dart';
import 'package:provider_start/core/exceptions/cache_exception.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/locator.dart';

class UsersRepositoryImpl implements UsersRepository {
  final remoteDataSource = locator<UsersRemoteDataSource>();
  final localDataSource = locator<UsersLocalDataSource>();
  final connectivityService = locator<ConnectivityService>();

  final _log = Logger('UsersRepositoryImpl');

  @override
  Future<User> fetchUser(int uid) async {
    if (uid == null) {
      throw RepositoryException('uid must not be null');
    }

    try {
      if (await connectivityService.isConnected) {
        final user = await remoteDataSource.fetchUser(uid);
        await localDataSource.cacheUser(user);
        return user;
      } else {
        final user = await localDataSource.fetchUser(uid);
        return user;
      }
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }
}
