import 'package:musicomapp/models/user.dart';
import 'package:http/http.dart' as http;

class BackendService {

  final String _baseUrl = "https://musicom.azurewebsites.net/api/v1";
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer '
  };
  static BackendService _instance;

  var client;

  BackendService._internal() {
    var _user = User.getInstance();
    if (_user != null) {
      headers['Authorization'] = 'Bearer ${_user.token}';
    }
    _instance = this;
  }

  BackendService getInstance() {
    if (_instance == null) {
      _instance = BackendService._internal();
    }
    return _instance;
  }

  Future<http.Response> get(String url, Map<String, String> params) async {
    try {
      if (client != null) {
        return await client.get(_baseUrl + url, headers: headers);
      } else {
        return await http.get(_baseUrl + url, headers: headers);
      }
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> data) async {
    try {
      if (client != null) {
        return await client.post(_baseUrl+url, headers: headers, body: data);
      } else {
        return await http.post(_baseUrl+url, headers: headers, body: data);
      }
    } catch (e) {
      return null;
    }
  }

  initClient() {
    if (client == null) {
      client = http.Client();
    }
  }

  closeClient() {
    if (client != null) {
      client.close();
      client = null;
    }
  }
}