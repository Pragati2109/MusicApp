import 'package:credicxo_task_music_app/helper/network_helper.dart';
import 'package:credicxo_task_music_app/helper/network_response.dart';
import 'package:credicxo_task_music_app/model/music_model.dart';

class MusicLyricsController{
  Future<MusicModel> getLyrics(int trackId) async{
    NetworkResponse response = await NetworkHelper.get('https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=56bfb87e51d544ba8db80914f4b376b4');
    if(response.isSuccess){
      var _rawLyrics = response.data['message']['body']['lyrics'];
      return MusicModel.fromJson(_rawLyrics);
    } else{
      throw Exception("Track Details not found");
    }
  }
}