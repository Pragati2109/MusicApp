import 'dart:convert';

import 'network_response.dart';
import 'package:http/http.dart' as http;

class NetworkHelper{
  static Future<NetworkResponse> get(String url) async {
    final response  = await http.get(Uri.parse(url));
    print("URL : $url");
    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);

    if(response.statusCode == 200){
      NetworkResponse dataResponse = NetworkResponse();
      dataResponse.statusCode = response.statusCode;
      dataResponse.messageCode = "SOME_SERVER_CODE";
      dataResponse.message ="data received";
      dataResponse.data = jsonDecode(response.body);
      dataResponse.isSuccess = true;
      return dataResponse;
    }else if(response.statusCode == 401){
      Map<String, dynamic> fullDataMap = jsonDecode(response.body);
      NetworkResponse dataResponse = NetworkResponse();
      dataResponse.statusCode = response.statusCode;
      dataResponse.messageCode = response.reasonPhrase;
      dataResponse.message =fullDataMap['error_msg'];
      dataResponse.data = fullDataMap;
      dataResponse.isSuccess = false;
      return dataResponse;
    }else{
      throw Exception('Get Response fail Exception code : ${response.statusCode}');
    }
  }
}