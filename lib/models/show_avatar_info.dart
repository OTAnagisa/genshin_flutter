class ShowAvatarInfo {
  ShowAvatarInfo({
    required this.avatarId,
    required this.level,
    required this.iconUrl,
  });

  final int avatarId;
  final int level;
  final String iconUrl;

  factory ShowAvatarInfo.fromJson(dynamic json) {
    return ShowAvatarInfo(
      avatarId: json['avatarId'] as int,
      level: json['level'] as int,
      iconUrl: json['iconUrl'] as String,
    );
  }
}
