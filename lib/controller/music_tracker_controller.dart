import 'package:credicxo_task_music_app/helper/network_helper.dart';
import 'package:credicxo_task_music_app/helper/network_response.dart';
import 'package:credicxo_task_music_app/model/music_model.dart';

class MusicTrackerController{
  Future<List<MusicModel>> fetchTrackingList() async{
    NetworkResponse response = await NetworkHelper.get('https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=56bfb87e51d544ba8db80914f4b376b4');
    if(response.isSuccess ?? false){
      List _rawTracker = response.data['message']['body']['track_list'];
      print("Raw tracker list : ${_rawTracker.length} and ${_rawTracker.toString()} ");
      List<MusicModel> musicModel = [];
      for(int i = 0; i <= _rawTracker.length - 1; i++){
        var element = _rawTracker[i]['track'];
        musicModel.add(MusicModel.fromJson(element));
      }
      return musicModel;
    } else{
      throw Exception("Tracker List is not load");
    }
  }
}