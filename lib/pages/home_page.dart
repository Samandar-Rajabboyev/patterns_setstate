// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_setstate/model/post_model.dart';
import 'package:patterns_setstate/services/http_service.dart';

import 'create_or_update_post.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    setState(() {
      if (response != null) {
        items = Network.parsePostList(response);
      } else {
        items = [];
      }
      isLoading = false;
    });
  }

  void _apiPostDelete(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    setState(() {
      if (response != null) {
        _apiPostList();
      }
      isLoading = false;
    });
  }

  void _apiPostCreate(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    setState(() {
      if (response != null) {
        _apiPostList();
      }
      isLoading = false;
    });
  }

  void _apiPostUpdate(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post));
    setState(() {
      if (response != null) {
        _apiPostList();
      }
      isLoading = false;
    });
  }

  _onCreatePost() async {
    await openDialog(context, type: DialogType.create).then((post) {
      if (post != null) _apiPostCreate(post);
    });
  }

  _onUpdatePost(Post post) async {
    await openDialog(context, type: DialogType.update, post: post).then((post) {
      if (post != null) _apiPostUpdate(post);
    });
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("setState"),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                return itemOfPost(items[index]);
              },
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: _onCreatePost,
          child: const Icon(Icons.add),
        ));
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      enabled: true,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Update',
            backgroundColor: Colors.indigo,
            icon: Icons.edit,
            onPressed: (BuildContext context) {
              _onUpdatePost(post);
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (_) {
              _apiPostDelete(post);
            },
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => DetailPage(id: post.id))),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title?.toUpperCase() ?? "",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(post.body ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
