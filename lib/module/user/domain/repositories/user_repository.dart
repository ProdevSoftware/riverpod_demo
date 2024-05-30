import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/user/data/data_source/user_data_sources.dart';
import 'package:riverpod_demo/user/data/repositires/user_repository_impl.dart';
import '../../data/models/user_response_model.dart';

final userRepositoryProvider = Provider(
    (ref) => UserRepositoryImpl(dataSource: ref.read(userDataSourceProvider)));

abstract class UserRepository {
  Future<(String?, List<User>?)> userList();
}
