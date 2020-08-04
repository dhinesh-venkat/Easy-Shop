import 'package:easy_shop/models/sub_group.dart';
import 'package:easy_shop/services/sub_group_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/sub_group.dart';
import '../models/api_response.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

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
  String _selectedIndex = "";

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
        return Center(child: Text("Please wait..."));
      }
      if (_apiResponse.error) {
        return Center(child: Text(_apiResponse.errorMessage));
      }
      return Container(
        height: 50,
        width: double.infinity,
        //margin: EdgeInsets.symmetric(vertical: 5.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _apiResponse.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(_apiResponse.data[index].value);
                setState(() {
                  _selectedIndex = _apiResponse.data[index].id;
                });
              },
              child: GradientCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _selectedIndex == _apiResponse.data[index].id
                      ? Text(_apiResponse.data[index].value,
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Fryo"))
                      : Text(_apiResponse.data[index].value,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Fryo")),
                ),
                gradient: Gradients.coldLinear,
                elevation: 20,
              ),
            );
          },
        ),
      );
    });
  }
}
