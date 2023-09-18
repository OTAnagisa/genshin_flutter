import 'package:genshin_flutter/models/show_avatar_info.dart';

class PlayerInfo {
  PlayerInfo({
    required this.nickname,
    required this.level,
    required this.worldLevel,
    required this.nameCardIcon,
    required this.finishAchievementNum,
    required this.towerFloorIndex,
    required this.towerLevelIndex,
    required this.showAvatarInfoList,
    // required this.showNameCardIdList,
    required this.profilePicture,
  });

  final String nickname;
  final int level;
  final int worldLevel;
  final String nameCardIcon;
  final int finishAchievementNum;
  final int towerFloorIndex;
  final int towerLevelIndex;
  final List<ShowAvatarInfo> showAvatarInfoList;
  // final List<int> showNameCardIdList;
  final String profilePicture;

  factory PlayerInfo.fromJson(dynamic json) {
    return PlayerInfo(
      nickname: json['nickname'] as String,
      level: json['level'] as int,
      worldLevel: json['worldLevel'] as int,
      nameCardIcon: json['nameCardIcon'] as String,
      finishAchievementNum: json['finishAchievementNum'] as int,
      towerFloorIndex: json['towerFloorIndex'] as int,
      towerLevelIndex: json['towerLevelIndex'] as int,
      showAvatarInfoList: List<ShowAvatarInfo>.from(
        json['showAvatarInfoList']
            .map((showAvatarInfo) => ShowAvatarInfo.fromJson(showAvatarInfo)),
      ),
      // showNameCardIdList: json['showNameCardIdList'] as List<int>,
      profilePicture: json['profilePicture']['iconUrl'],
    );
  }
}
