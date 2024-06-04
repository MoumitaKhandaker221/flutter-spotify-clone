import 'package:flutter/material.dart';
import 'package:spotify/constants/colors.dart';
import 'package:spotify/data/data.dart';
import 'package:spotify/view/tab/home/widgets/song_player.dart';
import 'package:spotify/view/top_hits/top_hits.dart';
import '../../../../api/Api.dart';

class Song {
  final String title;
  final String artist;
  final String thumbnailUrl;
  final String audioUrl;

  const Song(this.title, this.artist, this.thumbnailUrl, this.audioUrl);

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      json["strTrack"],
      json["strArtist"],
      json["strTrackThumb"],
      json["audioUrl"],
    );
  }
}

class TopMusic extends StatefulWidget {
  TopMusic({
    Key? key,
  }) : super(key: key);

  @override
  _TopMusicState createState() => _TopMusicState();
}

class _TopMusicState extends State<TopMusic>{

  var songList = [];
  @override
  void didChangeDependencies() async {

    var songListObject = await SongApi.getSongList();
    songList = songListObject["track"];

    setState(() {

    });
    super.didChangeDependencies();
  }
  List<Song> songs = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSongs();
  }

  Future<void> _fetchSongs() async {
    setState(() {
      isLoading = true;
    });
    try {
      var songListObject = await SongApi.getSongList();
      songs = songListObject["track"].map((song) => Song.fromJson(song)).toList();
    } catch (error) {
      print("Error fetching songs: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  SongPlayer? selectedSongPlayer;

  void navigateToSongPlayer(var song) {
    selectedSongPlayer = SongPlayer(selectedSong: song);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => selectedSongPlayer!,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: songList.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) {
            //final slid = slider[index];
            var song = songList[index];
            return InkWell(
                onTap: () {

                  print("Play Song");
                  navigateToSongPlayer(song);

                  },
            child: Column(
              children: [
                Container(
                  height: 145,
                  width: 145,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                    /*image:  DecorationImage(
                        image: AssetImage(album['strAlbumThumb']),
                        fit: BoxFit.cover,
                      )*/
                    //image: CachedNetworkImageProvider(url),
                  ),

                  child:song['strTrackThumb']== null? Image.network(
                    "https://www.theaudiodb.com/images/media/track/thumb/syswqy1340354244.jpg",
                  ): Image.network(
                    song['strTrackThumb'],
                  ),

                ),
                const SizedBox(height: 8,),
                Text(song["strTrack"], style: TextStyle(
                  color: ColorConstants.starterWhite,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ))
              ],
            )
            );
          }),
    );

  }


}
