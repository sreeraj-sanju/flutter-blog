import 'dart:convert';
import 'package:blog/services/user_service.dart';
import '../models/post.dart';
import '/models/api_response.dart';
import 'package:http/http.dart' as http;
import '/constant.dart';

// START FUNCTION FOR GET POST
Future<ApiResponse> getPosts() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    int token = await getToken();
    final response = await http.post(Uri.parse(getPostUrl),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['posts'].map((p)=> Post.fromJson(p)).toList();
        //we get list of posts, so we need to mapeach item to post
        apiResponse.data as List<dynamic>;
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
// END FUNCTION FOR GET POST

// START FUNCTION FOR CREATE POST
Future<ApiResponse> createPost(String body, String ? image) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(createPostUrl),
        headers: {'Accept': 'application/json'},
        body: image != null ? {'body': body, 'image': image} : {body: body});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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
// END FUNCTION FOR CREATE POST

