import 'package:credicxo_task_music_app/helper/network_helper.dart';
import 'package:credicxo_task_music_app/helper/network_response.dart';
import 'package:credicxo_task_music_app/model/music_model.dart';

class TrackDetailsController{
  Future<MusicModel> getTrackDetails(int trackId) async {
    NetworkResponse response = await NetworkHelper.get('https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=56bfb87e51d544ba8db80914f4b376b4');
    if(response.isSuccess){
      var _rawTrackDetails = response.data['message']['body']['track'];
      return MusicModel.fromJson(_rawTrackDetails);
    } else{
      throw Exception("Track Details not found");
    }
  }
}