import '../models/group.dart';
import '../models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

class GroupService {
  String url = MyApp.BASE_URL;

  Future<APIResponse<List<Group>>> getGroupList() {
    return http.get(url + '/api/group?&pagenumber=0&pagesize=10').then((data) {
      print('Status code : ${data.statusCode}');
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final groups = <Group>[];
        for (var item in jsonData) {
          groups.add(Group.fromJson(item));
        }
        return APIResponse<List<Group>>(data: groups);
      }
      return APIResponse<List<Group>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Group>>(
        error: true, errorMessage: 'An error occured'));
  }
}
