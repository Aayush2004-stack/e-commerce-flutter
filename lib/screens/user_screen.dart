import 'package:flutter/material.dart';
import 'package:my_app/provider/user_provider.dart';
import 'package:my_app/screens/add_user_screen.dart';
import 'package:my_app/screens/empty_page.dart';
import 'package:my_app/widgets/user_card.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<UserProvider>().getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add_user',
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddUserScreen()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add User'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          final userListItems = provider.users;

          if (userListItems.isEmpty) {
            return EmptyPage(title: 'Users', icon: Icons.person);
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              itemCount: userListItems.length,
              itemBuilder: (context, index) {
                return UserCard(user: userListItems[index]);
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        },
      ),
    );
  }
}
