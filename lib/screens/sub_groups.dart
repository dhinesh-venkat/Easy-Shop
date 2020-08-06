import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/group.dart';
import 'package:easy_shop/services/group_service.dart';
import 'package:easy_shop/widgets/subgroup_tab.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class SubGroupScreen extends StatefulWidget {
  //const SubGroup({Key key}) : super(key: key);

  final String groupTitle;
  final String groupID;
  SubGroupScreen({this.groupID, this.groupTitle});

  @override
  _SubGroupScreenState createState() => _SubGroupScreenState();
}

class _SubGroupScreenState extends State<SubGroupScreen> {
  GroupService get service => GetIt.I<GroupService>();

  APIResponse<List<Group>> _apiResponse;
  bool _isLoading = false;

  List<Tab> _tabs = [];

  @override
  void initState() {
    _fetchGroups();
    super.initState();
  }

  _fetchGroups() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getGroupList();
    for (int i = 0; i < _apiResponse.data.length; i++) {
      Tab groupTab = getGroupTab(_apiResponse.data[i]);
      _tabs.add(groupTab);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget getGroupTab(Group group) {
    return Tab(
      child: GradientCard(
        gradient: Gradients.taitanum,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            group.value,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget getSubGroupTab(String id) {
    return SubGroupTab(
      groupID: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (_apiResponse.error) {
          return Center(child: Text(_apiResponse.errorMessage));
        }
        return DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                title: Text("Easy Shop"),
                backgroundColor: Theme.of(context).primaryColor,
                bottom: TabBar(isScrollable: true, tabs: _tabs),
              ),
              body: Container(
                  height: 50,
                  child: TabBarView(
                      children: List<Widget>.generate(
                          _apiResponse.data.length,
                          (index) => SubGroupTab(
                                groupID: _apiResponse.data[index].id,
                              ))))),
        );
      },
    );
  }
}
