import 'package:flutter/material.dart';
import 'package:spotify/api/Api.dart';
import 'package:spotify/constants/colors.dart';



class WeeklyMusicList extends StatefulWidget {
   WeeklyMusicList({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeeklyMusicListState();
}

class _WeeklyMusicListState extends State<WeeklyMusicList>{

  var albumList = [];
  @override
  void didChangeDependencies() async {

    var albumListObject = await SongApi.getAlbumList();
    albumList = albumListObject["album"];

    setState(() {

    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: albumList.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) {
            //final slid = slider[index];
            var album = albumList[index];

            return Column(
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

                  child: album['strAlbumThumb']!= null? Image.network(
                    album['strAlbumThumb'],
                  ):Image.network(
                    "https://www.theaudiodb.com/images/media/track/thumb/syswqy1340354244.jpg",
                  ),

                ),
                const SizedBox(height: 8,),
                Text(album["strAlbum"], style: TextStyle(
                  color: ColorConstants.starterWhite,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ))
              ],
            );
          }),
    );
  }


}

