import 'package:easy_shop/models/sub_group.dart';
import 'package:easy_shop/services/sub_group_service.dart';
import 'package:easy_shop/widgets/loading_animation.dart';
import 'package:easy_shop/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/sub_group.dart';
import '../models/api_response.dart';
import 'package:hexcolor/hexcolor.dart';

class SubGroupTab extends StatefulWidget {
  //const SubGroupTop({Key key}) : super(key: key);

  final String groupID;
  SubGroupTab({this.groupID});

  @override
  _SubGroupTopState createState() => _SubGroupTopState();
}

class _SubGroupTopState extends State<SubGroupTab>
    with SingleTickerProviderStateMixin {
  SubGroupService get service => GetIt.I<SubGroupService>();

  APIResponse<List<SubGroup>> _apiResponse;

  bool _isLoading = false;
  List<Tab> _tabs = [];
  TabController _tabController;

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

    for (int i = 0; i < _apiResponse.data.length; i++) {
      Tab subGroupTab = getSubGroupTabs(_apiResponse.data[i].value);
      _tabs.add(subGroupTab);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget getSubGroupTabs(String value) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (_isLoading) {
        // return Center(
        //     child:
        //         Text("Please wait...", style: TextStyle(color: Colors.white)));
        return loadingAnimation();
      }
      if (_apiResponse.error) {
        return Center(child: Text(_apiResponse.errorMessage));
      }
      return DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBar(
                elevation: 0.0,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(horizontal: 2.5),
                    indicator: ShapeDecoration(
                        gradient: LinearGradient(
                            colors: [Hexcolor('#FE5F75'), Hexcolor('#FC9842')]),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: _tabs),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TabBarView(
                  controller: _tabController,
                  children: List<Widget>.generate(
                      _apiResponse.data.length,
                      (index) => ProductsGrid(
                            groupId: widget.groupID,
                            subGroupId: _apiResponse.data[index].id,
                          ))),
            ),
          ));
    });
  }
}
