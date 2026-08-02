import 'package:flutter/material.dart';
import 'package:my_app/model/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        child: ClipOval(
          child: Image.network(
            user.avatar,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.black38,
              );
            },
          ),
        ),
      ),

      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}
