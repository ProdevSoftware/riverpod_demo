part of 'user_data_sources.dart';

class UserDataSourceImpl implements UserDataSource{

  UserDataSourceImpl({required this.apiClient}  );
  final ApiClient apiClient;
  @override
  Future<Response> userList()  {
    return apiClient.get(
      ApiConstant.userList,
    );
  }


}