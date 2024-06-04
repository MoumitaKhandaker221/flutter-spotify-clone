import 'package:flutter/material.dart';

class BanglaSongListPage extends StatelessWidget {
  final List<Map<String, String>> banglaSongs;
  final bool isGuestUser;

  const BanglaSongListPage({Key? key, required this.isGuestUser, required this.banglaSongs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bangla Songs'),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: banglaSongs.length,
        itemBuilder: (context, index) {
          return SongWidget(
            songData: banglaSongs[index],
          );
        },
      ),
    );
  }
}

class SongWidget extends StatelessWidget {
  final Map<String, String> songData;

  SongWidget({required this.songData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(songData['imageUrl'] ?? ''),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songData['name'] ?? 'Unknown Song',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  songData['artist'] ?? 'Unknown Artist',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  songData['album'] ?? 'Unknown Album',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
