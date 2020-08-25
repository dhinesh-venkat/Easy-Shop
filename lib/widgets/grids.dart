import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/group.dart';
import 'package:easy_shop/services/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import '../screens/sub_groups.dart';

class Grids extends StatefulWidget {
  //const Grids({Key key}) : super(key: key);

  @override
  _GridsState createState() => _GridsState();
}

class _GridsState extends State<Grids> {
  GroupService get service => GetIt.I<GroupService>();

  APIResponse<List<Group>> _apiResponse;
  bool _isLoading = false;

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

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(
                child: Text(
              "Loading...",
              style: TextStyle(color: Colors.white),
            ));
          }
          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }
          return GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: _apiResponse.data.length,
              itemBuilder: (BuildContext _, int item) {
                return Container(
                  height: 180,
                  width: 180,
                  margin: EdgeInsets.all(1),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1.5,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          color: Colors.white,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SubGroupScreen(
                                      groupID: _apiResponse.data[item].id,
                                      groupTitle: _apiResponse.data[item].value,
                                    )));
                          },
                          // child: Image.network(
                          //   _apiResponse.data[item].imageUrl,
                          //   width: 100,
                          // ),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/no_image.png",
                            image: _apiResponse.data[item].imageUrl,
                            width: 100,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 15,
                          left: 50,
                          child: Text(_apiResponse.data[item].value,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
