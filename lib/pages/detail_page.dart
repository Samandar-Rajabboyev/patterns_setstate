import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  dynamic id;
  DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;
  Post? post;

  void _apiPostList(id) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET('${Network.API_DETAIL}$id', Network.paramsEmpty());
    setState(() {
      if (response != null) {
        post = Post.fromJson(jsonDecode(response));
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    _apiPostList(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                post?.title ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                post?.body ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
