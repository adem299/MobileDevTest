import 'package:flutter/material.dart';
import 'package:mobiledev_test_app/model/user_model.dart';
import 'package:mobiledev_test_app/provider/user_provider.dart';
import 'package:mobiledev_test_app/utils/colors.dart';
import 'package:mobiledev_test_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUsers();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !Provider.of<UserProvider>(context, listen: false).isLoading) {
        Provider.of<UserProvider>(context, listen: false).loadMoreUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Third Screen',
      ),
      backgroundColor: Colors.white,
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading && userProvider.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userProvider.users.isEmpty) {
            return const Center(child: Text('No users available'));
          }

          return RefreshIndicator(
            onRefresh: () => userProvider.refreshUsers(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                controller: _scrollController,
                itemCount: userProvider.hasMoreData ? userProvider.users.length + 1 : userProvider.users.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey[300],
                    thickness: 0.75,
                  );
                },
                itemBuilder: (context, index) {
                  if (index == userProvider.users.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final UserModel user = userProvider.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                      maxRadius: 30,
                      minRadius: 30,
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
                    ),
                    subtitle: Text(
                      user.email,
                      style: const TextStyle(fontSize: 10, color: subtileColor),
                    ),
                    onTap: () {
                      context.read<UserProvider>().selectedUserName = '${user.firstName} ${user.lastName}';
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
