import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/service/network/api_client.dart';
import 'package:riverpod_demo/utils/api_constant.dart';
part 'user_data_sources_impl.dart';

final userDataSourceProvider = Provider(
    (ref) => UserDataSourceImpl(apiClient: ref.read(apiClientProvider)));

abstract class UserDataSource {
  Future<Response> userList();
}
