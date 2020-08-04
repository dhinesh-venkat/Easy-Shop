import 'package:flutter/material.dart';
import '../services/group_service.dart';
import '../models/api_response.dart';
import '../models/group.dart';
import 'package:get_it/get_it.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class ChangeGroup extends StatefulWidget {
  // ChangeGroup({Key key}) : super(key: key);

  final String groupTitle;

  ChangeGroup(this.groupTitle);

  @override
  _ChangeGroupState createState() => _ChangeGroupState();
}

class _ChangeGroupState extends State<ChangeGroup> {
  String _selectedIndex = "";
  GroupService get service => GetIt.I<GroupService>();

  APIResponse<List<Group>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _selectedIndex = widget.groupTitle;
    _fetchGroups();
    super.initState();
  }

  _fetchGroups() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getGroupList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (_isLoading) {
        return Center(child: Text(""));
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
                  _selectedIndex = _apiResponse.data[index].value;
                });
              },
              child: GradientCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _selectedIndex == _apiResponse.data[index].value
                      ? Text(_apiResponse.data[index].value,
                          style: TextStyle(
                              color: Colors.blue, fontFamily: "Roboto"))
                      : Text(_apiResponse.data[index].value,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: "Roboto")),
                ),
                gradient: Gradients.taitanum,
                elevation: 12,
              ),
            );
          },
        ),
      );
    });
  }
}
