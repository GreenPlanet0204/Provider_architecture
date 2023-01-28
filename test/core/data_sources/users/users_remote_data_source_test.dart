import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/data_sources/users/users_remote_data_source.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/locator.dart';

import '../../../data/mocks.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  UsersRemoteDataSource usersRemoteDataSource;
  HttpService httpService;

  setUp(() {
    locator.allowReassignment = true;

    locator.registerSingleton<HttpService>(MockHttpService());
    httpService = locator<HttpService>();

    locator
        .registerSingleton<UsersRemoteDataSource>(UsersRemoteDataSourceImpl());
    usersRemoteDataSource = locator<UsersRemoteDataSource>();
  });

  test('should call httpService.getHttp with correct uid when we fetch user',
      () async {
    // arrange
    final uid = 1;
    final url = '${ApiRoutes.users}/$uid';
    when(httpService.getHttp(url))
        .thenAnswer((_) => Future.value(mockUserJson));

    // act
    await usersRemoteDataSource.fetchUser(uid);

    // assert
    verify(httpService.getHttp(url));
  });

  test('should convert json data to posts when we fetch user', () async {
    // arrange
    final uid = 1;
    final url = '${ApiRoutes.users}/$uid';
    when(httpService.getHttp(url))
        .thenAnswer((_) => Future.value(mockUserJson));
    final mockUser = User.fromMap(mockUserJson);

    // act
    final user = await usersRemoteDataSource.fetchUser(uid);

    // assert
    expect(user, equals(mockUser));
  });
}
