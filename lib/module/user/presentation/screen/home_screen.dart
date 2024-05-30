import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/user/data/models/user_response_model.dart';
import 'package:riverpod_demo/user/presentation/riverpod/user_notifier.dart';
import 'package:riverpod_demo/utils/color_constant.dart';
import 'package:riverpod_demo/utils/image_const.dart';
import 'package:riverpod_demo/utils/string_constant.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getFetchData();
    });
  }

  Future<void> getFetchData() async {
    await ref.read(userResultNotifier.notifier).userList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userResultNotifier);
    if (state.userStatus == UserStatus.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state.userStatus == UserStatus.error) {
      return const Scaffold(
        body: Center(
          child: Text('Error occurred while fetching user data'),
        ),
      );
    } else if (state.userStatus == UserStatus.success) {
      final List<User>? users = state.users;
      return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back_ios, color: ColorConstant.black),
          ),
          title: const Text(StringConstant.userList),
          backgroundColor: ColorConstant.colorE1BEE7,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: users?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            users?[index].avatar ?? '',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) =>
                                const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImageConstant.profileImage,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${users?[index].name}',
                              style: const TextStyle(
                                color: ColorConstant.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${users?[index].email}',
                              style: const TextStyle(
                                color: ColorConstant.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text('Unknown state'),
        ),
      );
    }
  }
}
