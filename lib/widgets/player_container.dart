import 'package:flutter/material.dart';
import 'package:genshin_flutter/models/player_info.dart';
import 'package:genshin_flutter/widgets/show_avatar_container.dart';

class PlayerContainer extends StatelessWidget {
  const PlayerContainer({super.key, this.playerInfo});

  final PlayerInfo? playerInfo;

  @override
  Widget build(BuildContext context) {
    if (playerInfo != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFf0ebe3),
            borderRadius: const BorderRadius.all(
              Radius.circular(32),
            ),
            image: DecorationImage(
              image: NetworkImage(playerInfo!.nameCardIcon),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundImage:
                            NetworkImage(playerInfo!.profilePicture),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        playerInfo!.nickname,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        '冒険ランク: ${playerInfo!.level.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '世界ランク: ${playerInfo!.worldLevel.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '深鏡螺旋: ${playerInfo!.towerFloorIndex.toString()}-${playerInfo!.towerLevelIndex.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'アチーブメント: ${playerInfo!.finishAchievementNum.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Text(
                      'キャラクターラインナップ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12, left: 12, right: 12),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        children: playerInfo!.showAvatarInfoList
                            .map((showAvatarInfo) => ShowAvatarContainer(
                                showAvatarInfo: showAvatarInfo))
                            .toList(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return const ListTile(title: Text('...'));
    }
  }
}
