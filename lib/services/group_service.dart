import '../models/group.dart';
import '../models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

class GroupService {
  String url = MyApp.BASE_URL;

  Future<APIResponse<List<Group>>> getGroupList() {
    return http.get(url + '/api/group?&pagenumber=0&pagesize=10').then((data) {
      print(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final groups = <Group>[];
        for (var item in jsonData) {
          final group = Group(
              id: item['ID'],
              value: item['VALUE'],
              imageUrl:
                  "https://cdn.pixabay.com/photo/2013/07/13/12/34/handbag-159884_960_720.png");
          groups.add(group);
        }
        return APIResponse<List<Group>>(data: groups);
      }
      return APIResponse<List<Group>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Group>>(
        error: true, errorMessage: 'An error occured'));
  }
}
