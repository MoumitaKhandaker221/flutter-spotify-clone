import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/constants/colors.dart';
import 'package:spotify/data/data.dart';
import 'package:spotify/view/login/login_page.dart';
import 'package:spotify/view/tab/search/widget/browse_card.dart';
import 'package:spotify/view/tab/search/widget/podcast.dart';
import 'package:spotify/view/tab/search/widget/search_input.dart';
import 'package:spotify/view/tab/widgets/custom_title.dart';
import 'package:spotify/view/tab/widgets/welcome_title.dart';
import '../../../constants/AppConstants.dart';
import '../more/widget/bangla_song_list_page.dart';
import 'package:spotify/view/tab/more/widget/bangla_song_list_page.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({Key? key});

  @override
  Widget build(BuildContext context) {

    List<Map<String, String>> banglaSongs = [
      {
        'name': 'Song 1',
        'artist': 'Artist 1',
        'album': 'Album 1',
        'imageUrl': 'https://example.com/song1.jpg',
      },
      {
        'name': 'Song 2',
        'artist': 'Artist 2',
        'album': 'Album 2',
        'imageUrl': 'https://example.com/song2.jpg',
      },
      {
        'name': 'Song 3',
        'artist': 'Artist 3',
        'album': 'Album 3',
        'imageUrl': 'https://example.com/song1.jpg',
      },
      {
        'name': 'Song 4',
        'artist': 'Artist 4',
        'album': 'Album 4',
        'imageUrl': 'https://example.com/song2.jpg',
      },
      {
        'name': 'Song 5',
        'artist': 'Artist 5',
        'album': 'Album 5',
        'imageUrl': 'https://example.com/song1.jpg',
      },
      {
        'name': 'Song 6',
        'artist': 'Artist 6',
        'album': 'Album 6',
        'imageUrl': 'https://example.com/song2.jpg',
      },
      {
        'name': 'Song 7',
        'artist': 'Artist 7',
        'album': 'Album 7',
        'imageUrl': 'https://example.com/song1.jpg',
      },
      {
        'name': 'Song 8',
        'artist': 'Artist 8',
        'album': 'Album 8',
        'imageUrl': 'https://example.com/song2.jpg',
      },
      {
        'name': 'Song 9',
        'artist': 'Artist 9',
        'album': 'Album 9',
        'imageUrl': 'https://example.com/song1.jpg',
      },
      {
        'name': 'Song 10',
        'artist': 'Artist 10',
        'album': 'Album 10',
        'imageUrl': 'https://example.com/song2.jpg',
      },
      {
        'name': 'Song 11',
        'artist': 'Artist 11',
        'album': 'Album 11',
        'imageUrl': 'https://example.com/song1.jpg',
      },
      {
        'name': 'Song 12',
        'artist': 'Artist 12',
        'album': 'Album 12',
        'imageUrl': 'https://example.com/song2.jpg',
      },
    ];

    void navigateToBanglaSongListPage()async {
      final prefs = await SharedPreferences.getInstance();
      bool? _isLoggedIn = prefs.getBool(AppConstants.isLoggedInKey);

      if(_isLoggedIn==true){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BanglaSongListPage(
              isGuestUser: true,
              banglaSongs:banglaSongs,),

          ),
        );
      } else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Log In First'),
            content: const Text('Please enter valid username and password to login'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

    }


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 54,),
              const WelcomeTitle(title: 'Search'),
              const SizedBox(height: 32,),
              const SearchInput(),
              const SizedBox(height: 13,),
              Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: searchList.map((search) => Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: ColorConstants.cardBackGroundColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(search, style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w400
                      ),)
                  ),).toList()
              ),
              const SizedBox(height: 24,),
              const CustomTitle(title: 'Podcast’s'),
              const SizedBox(height: 13,),
              const PodCast(),
              const SizedBox(height: 12,),
              const CustomTitle(title: 'Browse all'),
              const SizedBox(height: 13,),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  BrowseCard(
                      title: 'Made For You',
                      color1: '#E02FCF',
                      color2: '#00C188'
                  ),
                  BrowseCard(
                      title: 'Charts',
                      color1: '#0A3CEC',
                      color2: '#4DD4AC'
                  ),
                  GestureDetector(
                    //onTap: isLoggedIn ? navigateToBanglaSongListPage : null,
                    onTap:  navigateToBanglaSongListPage,
                    child: BrowseCard(
                      title: 'Discover',
                      color1: '#0A3CEC',
                      color2: '#D9DD01',
                    ),
                  ),

                  BrowseCard(
                      title: 'New Release',
                      color1: '#0E31AE',
                      color2: '#DD1010'
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
