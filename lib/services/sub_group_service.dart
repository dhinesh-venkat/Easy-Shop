import '../models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import '../models/sub_group.dart';

class SubGroupService {
  String url = MyApp.BASE_URL;

  Future<APIResponse<List<SubGroup>>> getSubGroupList(String groupID) {
    return http.get(url + '/api/subgroup?&groupid=' + groupID).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final subGroups = <SubGroup>[];
        for (var item in jsonData) {
          final group = SubGroup(
              id: item['ID'],
              value: item['VALUE'],
              imageUrl:
                  "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png");
          subGroups.add(group);
        }
        return APIResponse<List<SubGroup>>(data: subGroups);
      }
      return APIResponse<List<SubGroup>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<SubGroup>>(
        error: true, errorMessage: 'An error occured'));
  }
}