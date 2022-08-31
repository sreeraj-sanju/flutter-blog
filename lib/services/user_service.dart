import 'dart:convert';
import 'package:blog/models/api_response.dart';
import 'package:blog/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

// START FUNCTION FOR LOGIN
Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(loginUrl),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)[0]];
        break;
      default:
        apiResponse.error = serviceError;
        break;
    }
  } catch (e) {
    apiResponse.error = serviceError;
  }
  return apiResponse;
}
// END FUNCTION FOR LOGIN

// START FUNCTION FOR REGISTER
Future<ApiResponse> register(String name, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(registerUrl),
        headers: {'Accept': 'application/json'},
        body: {'name': name, 'email': email, 'password': password});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      default:
        apiResponse.error = serviceError;
        break;
    }
  } catch (e) {
    apiResponse.error = serviceError;
  }
  return apiResponse;
}
// END FUNCTION FOR REGISTER

// START FUNCTION FOR GET USER DETAILS
Future<ApiResponse> user_details() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(userUrl),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      default:
        apiResponse.error = serviceError;
        break;
    }
  } catch (e) {
    apiResponse.error = serviceError;
  }
  return apiResponse;
}
// END FUNCTION FOR USER DETAILS

// START FUNCTION FOR GET TOKEN FROM SHARED PREFERENCES
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}
//END FUNCTION FOR GET TOKEN FROM SHARED PREFERENCES

// START FUNCTION FOR USER ID
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}
// END FUNCTION FOR USER ID

// START FUNCTION FOR LOG OUT
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}
// END FUNCTION FOR LOG OUT