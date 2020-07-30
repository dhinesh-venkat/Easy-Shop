import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/group.dart';
import 'package:easy_shop/services/group_service.dart';
import 'package:flutter/material.dart';
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
    return Builder(
      builder: (_) {
        if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (_apiResponse.error) {
              return Center(child: Text(_apiResponse.errorMessage));
            }
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _apiResponse.data.length,
            itemBuilder: (BuildContext _, int item) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(13.0),
                child: GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SubGroupScreen(
                                groupTitle: _apiResponse.data[item].value,
                              )));
                    },
                    child: Image.network(
                      _apiResponse.data[item].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  footer: GridTileBar(
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.25),
                    title: Text(_apiResponse.data[item].value),
                  ),
                ),
              );
            });
      },
    );
  }
}
