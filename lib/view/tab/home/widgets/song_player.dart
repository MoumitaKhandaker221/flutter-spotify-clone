import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayer extends StatefulWidget {
  final Map<String, dynamic> selectedSong;

  SongPlayer({Key? key, required this.selectedSong}) : super(key: key);

  @override
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      String audioUrl = "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3";
      await _player.setUrl(audioUrl);
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _togglePlayer() {
    setState(() {
      if (_isPlaying) {
        _player.pause();
      } else {
        _player.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedSong["strTrack"] ?? "Unknown Song"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(widget.selectedSong["albumImageUrl"] ?? ""),
            ),
            SizedBox(height: 20),
            Text(
              widget.selectedSong["strTrack"] ?? "Unknown Song",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.selectedSong["strAlbum"] ?? "Unknown Album",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.selectedSong["strArtist"] ?? "Unknown Artist",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: () {

                  },
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  color: Colors.white,
                  iconSize: 64,
                  onPressed: () {
                    _togglePlayer();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: () {

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
