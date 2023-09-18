import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genshin_flutter/models/player_info.dart';
import 'package:http/http.dart' as http;

import '../widgets/player_container.dart';

class PlayerSearchScreen extends StatefulWidget {
  const PlayerSearchScreen({super.key});

  @override
  State<PlayerSearchScreen> createState() => _PlayerSearchScreenState();
}

class _PlayerSearchScreenState extends State<PlayerSearchScreen> {
  PlayerInfo? playerInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('原神ユーザー検索'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: 'UIDを入力してください',
              ),
              onSubmitted: (String uid) async {
                final results = await searchGenshinPlayer(uid);
                setState(() => playerInfo = results);
              },
            ),
          ),
          PlayerContainer(playerInfo: playerInfo),
        ],
      ),
    );
  }

  Future<PlayerInfo?> searchGenshinPlayer(String uid) async {
    if (uid.isEmpty) return null;
    // uri作成
    final uri = Uri.https('enka.network', '/api/uid/$uid');

    // Qiita APIにリクエスト
    final http.Response res = await http.get(uri);

    if (res.statusCode != 200) {
      return null;
    }

    final Map<String, dynamic> body = jsonDecode(res.body);
    final Map<String, dynamic> playerInfo = body['playerInfo'];

    final String charactersloadData =
        await rootBundle.loadString('json/characters.json');
    final Map<String, dynamic> charactersMap = json.decode(charactersloadData);

    final String profilePictureAvatarId =
        playerInfo['profilePicture']['avatarId'].toString();

    playerInfo['profilePicture']['iconUrl'] =
        fetchAvatarIconUrl(profilePictureAvatarId, charactersMap);

    for (var avatarId in playerInfo['showAvatarInfoList']) {
      avatarId['iconUrl'] =
          fetchAvatarIconUrl(avatarId['avatarId'].toString(), charactersMap);
    }

    final String namecardsLoadData =
        await rootBundle.loadString('json/namecards.json');
    final Map<String, dynamic> namecardMap = json.decode(namecardsLoadData);
    final nameCardId = playerInfo['nameCardId'];
    playerInfo['nameCardIcon'] =
        'https://enka.network/ui/${namecardMap[nameCardId.toString()]["icon"]}.png';

    return PlayerInfo.fromJson(playerInfo);
  }

  String fetchAvatarIconUrl(
      String avatarId, Map<String, dynamic> charactersMap) {
    // キャラクターアイコンURL取得
    final targetCharacterInfo =
        charactersMap.containsKey(avatarId) ? charactersMap[avatarId] : null;

    if (targetCharacterInfo.isEmpty) {
      return '';
    }

    var icon = '';
    if (targetCharacterInfo.containsKey('SideIconName')) {
      final String sideIconName = targetCharacterInfo['SideIconName'];
      icon = sideIconName.replaceAll('_Side', '');
    } else if (targetCharacterInfo.containsKey('Costumes')) {
      final Map<String, dynamic> costumes = targetCharacterInfo['Costumes'];
      for (var costume in costumes.values) {
        if (costume.containsKey('icon')) {
          icon = costume['icon'];
          break;
        }
      }
    }

    return 'https://enka.network/ui/$icon.png';
  }
}
