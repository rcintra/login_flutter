import 'dart:convert' as convert;
import 'dart:convert';
import 'package:login_flutter/domain/response.dart';
import 'package:http/http.dart' as http;


class LoginService {

  static Future<Response> login(String login, String senha) async {

    var url = "http://livrowebservices.com.br/rest/login";

    final response = await http.post(url, body: {"login": login, "senha": senha});
    final s = response.body;
    print(s);

    /*final Map<String, dynamic> map = json.decode(s);

    String status = map["status"];
    String msg = map["msg"];

    final r = Response(status, msg);

    return r;*/

    return Response.fromJson(json.decode(s));

  }

}