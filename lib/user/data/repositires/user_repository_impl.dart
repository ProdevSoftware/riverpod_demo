import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_demo/user/data/data_source/user_data_sources.dart';
import 'package:riverpod_demo/user/data/models/user_response_model.dart';
import 'package:riverpod_demo/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<(String?, List<User>?)> userList() async {
    try {
      Response response = await dataSource.userList();

      List<User> users =
          (response.data as List).map((json) => User.fromJson(json)).toList();
      return switch (response) {
        (final r) when r.statusCode == 200 => (
            null,
            users,
          ),
        _ => ("Something went wrong", null),
      };
    } catch (e, stackTrace) {
      Logger().e(e.toString());
      Logger().e(stackTrace.toString());
      return (e.toString(), null);
    }
  }
}
