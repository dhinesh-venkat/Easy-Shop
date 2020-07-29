import '../models/group.dart';
import '../models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

class GroupService {
  String url = MyApp.BASE_URL;

  Future<APIResponse<List<Group>>> getGroupList() {
    return http.get(url + '/api//group?&pagenumber=0&pagesize=10').then((data) {
      if(data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final groups = <Group>[];
        for(var item in jsonData) {
          final group = Group(id: item['ID'], value: item['VALUE'],imageUrl: "https://cdn.pixabay.com/photo/2015/09/02/12/25/basket-918416_960_720.jpg");
        groups.add(group);
        }
        return APIResponse<List<Group>>(data: groups);
      }
      return APIResponse<List<Group>>(error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Group>>(error: true, errorMessage: 'An error occured'));;
    // return [
    //   Group(
    //       id: "1",
    //       value: "Oil",
    //       imageUrl:
    //           "https://cdn.pixabay.com/photo/2015/09/02/12/25/basket-918416_960_720.jpg"),
    //   Group(
    //       id: "2",
    //       value: "Beauty",
    //       imageUrl:
    //           "https://cdn.pixabay.com/photo/2015/09/02/12/25/basket-918416_960_720.jpg"),
    //   Group(
    //       id: "3",
    //       value: "Vitamin",
    //       imageUrl:
    //           "https://cdn.pixabay.com/photo/2015/09/02/12/25/basket-918416_960_720.jpg"),
    //   Group(
    //       id: "4",
    //       value: "Electronics",
    //       imageUrl:
    //           "https://cdn.pixabay.com/photo/2015/09/02/12/25/basket-918416_960_720.jpg")
    // ];
  }
}
