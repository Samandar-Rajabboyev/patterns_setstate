import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:patterns_setstate/model/post_model.dart';
import 'package:patterns_setstate/services/http_service.dart';

void main() {
  test("Post detail is null", () async {
    var response = await Network.GET('${Network.API_DETAIL}2', Network.paramsEmpty());
    expect(response, isNotNull);
    Post post = Post.fromJson(jsonDecode(response ?? ''));
    expect(post.id, equals(2));
  });
}
