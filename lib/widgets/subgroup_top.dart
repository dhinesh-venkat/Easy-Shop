import 'package:easy_shop/models/sub_group.dart';
import 'package:easy_shop/services/sub_group_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/sub_group.dart';
import '../models/api_response.dart';

class SubGroupTop extends StatefulWidget {
  //const SubGroupTop({Key key}) : super(key: key);

  final String groupID;
  SubGroupTop(this.groupID);

  @override
  _SubGroupTopState createState() => _SubGroupTopState();
}

class _SubGroupTopState extends State<SubGroupTop> {
  SubGroupService get service => GetIt.I<SubGroupService>();

  APIResponse<List<SubGroup>> _apiResponse;

  bool _isLoading = false;

  @override
  void initState() {
    _fetchSubGroups(widget.groupID);
    super.initState();
  }

  _fetchSubGroups(String groupID) async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getSubGroupList(groupID);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (_isLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (_apiResponse.error) {
        return Center(child: Text(_apiResponse.errorMessage));
      }
      return Container(
        height: 90,
        width: double.infinity,
        margin: EdgeInsets.all(14.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _apiResponse.data.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8),
                  height: 70,
                  width: 70,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          child:
                              Image.network(_apiResponse.data[index].imageUrl),
                        ),
                      ),
                      FittedBox(child: Text(_apiResponse.data[index].value)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
