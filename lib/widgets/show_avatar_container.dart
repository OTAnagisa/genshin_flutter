import 'package:flutter/material.dart';

import '../models/show_avatar_info.dart';

class ShowAvatarContainer extends StatelessWidget {
  const ShowAvatarContainer({super.key, required this.showAvatarInfo});

  final ShowAvatarInfo showAvatarInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(showAvatarInfo.iconUrl),
        ),
        Text(
          'level: ${showAvatarInfo.level}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
