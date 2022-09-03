import 'package:flutter/material.dart';

import '../model/post_model.dart';

enum DialogType { create, update }

Future<Post?> openDialog(BuildContext context, {required DialogType type, Post? post}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return DialogWidget(type: type, post: post);
    },
  );
}

class DialogWidget extends StatefulWidget {
  final DialogType type;
  final Post? post;
  const DialogWidget({
    Key? key,
    required this.type,
    this.post,
  }) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool functionIsCreate = true;

  _onSubmit() {
    String title = titleController.text;
    String body = bodyController.text;

    if (title == null || title.isEmpty) return;
    if (body == null || body.isEmpty) return;

    Post post = Post(title: title, body: body, userId: 1);

    Navigator.of(context).pop(post);
  }

  @override
  void initState() {
    functionIsCreate = widget.type == DialogType.create;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${functionIsCreate ? "Create" : "Update"} a Post'),
          const SizedBox(height: 8),
          TextField(
            controller: titleController,
            expands: false,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: bodyController,
            expands: false,
            maxLines: 5,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            ),
          ),
          MaterialButton(
            onPressed: _onSubmit,
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
            focusElevation: 0,
            disabledElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            highlightColor: Colors.indigo.withOpacity(.3),
            splashColor: Colors.indigo,
            child: Text(
              functionIsCreate ? "Create" : "Update",
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
