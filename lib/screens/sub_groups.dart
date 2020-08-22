import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/group.dart';
import 'package:easy_shop/services/group_service.dart';
import 'package:easy_shop/widgets/subgroup_tab.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'cart_screen.dart';

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
  int _initialIndex = 0;
  String currentGroupId = '';

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
      if (_apiResponse.data[i].id == widget.groupID) {
        _initialIndex = i;
      }
      Tab groupTab = getGroupTab(_apiResponse.data[i]);
      _tabs.add(groupTab);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget getGroupTab(Group group) {
    return Tab(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          group.value,
          style: TextStyle(color: Colors.white),
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
          initialIndex: _initialIndex,
          length: _tabs.length,
          child: Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              })
        ],
                title: Text("Easy Shop"),
                backgroundColor: Theme.of(context).primaryColor,
                bottom: TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 5),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 0.01,
                  indicator: ShapeDecoration(
                    gradient: Gradients.taitanum,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                    onTap: (value) {
                      setState(() {
                        currentGroupId = _apiResponse.data[value].id;
                      });
                    },
                    isScrollable: true,
                    tabs: _tabs),
              ),
              body: Container(
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
