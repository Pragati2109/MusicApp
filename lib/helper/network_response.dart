class NetworkResponse{
  int statusCode;
  bool isSuccess;
  String messageCode;
  String message;
  String body;
  Map<String, dynamic> data;

  NetworkResponse({this.statusCode, this.messageCode, this.message, this.data, this.isSuccess, this.body});
}