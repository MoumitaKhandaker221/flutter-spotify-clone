import 'package:flutter/material.dart';
import 'package:spotify/view/all_music/components/song_list.dart';
import 'package:spotify/view/tab/home/widgets/artist.dart';
import 'package:spotify/view/tab/home/widgets/bangla_music.dart';
import 'package:spotify/view/tab/home/widgets/top_music.dart';
import 'package:spotify/view/tab/home/widgets/weekly_music_list.dart';
import 'package:spotify/view/tab/home/widgets/weekly_title.dart';
import 'package:spotify/view/tab/widgets/custom_title.dart';
import 'package:spotify/view/tab/widgets/welcome_title.dart';


class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override


  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            SizedBox(height: 54,),
            WelcomeTitle(title: 'Good Morning',),
            SizedBox(height: 32,),
            WeeklyTitle(),
            SizedBox(height: 24,),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SongList()),
              );
            },
                child: Text("Button")),
            WeeklyMusicList(),
            SizedBox(height: 16,),
            CustomTitle(title: 'Bangla Songs'),
            BanglaMusic(),
            SizedBox(height: 16,),
            CustomTitle(title: 'Your Top Mixes'),
            SizedBox(height: 12,),
            TopMusic(),
            SizedBox(height: 12,),
            CustomTitle(title: 'Suggested artists'),
            SizedBox(height: 24,),
            Artist()
          ],
        ),
      ),
    );
  }
}
