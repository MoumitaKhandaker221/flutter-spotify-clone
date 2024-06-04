
import 'package:dio/dio.dart';

class SongApi{


  static getAlbumList() async {
    final dio = Dio();
    final response = await dio.get('https://www.theaudiodb.com/api/v1/json/2/album.php?i=112024');
    if(response != null){
      return response.data;
      print(response.data);
    }else{
      return null;
    }

  }

  static getSongList() async {
    final dio = Dio();
    final response = await dio.get('https://www.theaudiodb.com/api/v1/json/2/track.php?m=2115888');
    //final response = await dio.get('https://www.theaudiodb.com/api/v1/json/2/searchtrack.php?s=coldplay&t=yellow');
    if(response != null){
      return response.data;
      print(response.data);
    }else{
      return null;
    }

  }

  static getArtistList() async {
    final dio = Dio();
    final response = await dio.get('https://www.theaudiodb.com/api/v1/json/2/track.php?m=2115888');
    //final response = await dio.get('https://www.theaudiodb.com/api/v1/json/2/searchtrack.php?s=coldplay&t=yellow');
    if(response != null){
      return response.data;
      print(response.data);
    }else{
      return null;
    }

  }

}