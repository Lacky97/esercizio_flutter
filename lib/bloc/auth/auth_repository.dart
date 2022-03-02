
import 'package:http/http.dart';
import 'dart:convert';

class AuthRepository {
  Future<String> login(String email, String password) async {
    try{
    final uri = Uri.parse('https://reqres.in/api/login');
    final headers = {'Content-Type': 'application/json'};

    // Preparazione body per effetuare http post
    Map<String, dynamic> body = {
      "email": email,
      "password": password
    };

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    Map<String,dynamic> responseBody = json.decode(response.body);

    if(statusCode == 200) {
      // Se l'api ritorna 200 OK
      // ritorno il token di login
      return responseBody['token'];
    } else {
      // Se l'api non ritorna 200 ok
      // ritorno una stinga vuota per poi mostrare un messaggio di errore
      return '';
    }} catch (e) {
      // Se rispontriamo errori durante la chiamata http
      // mostriamo un messaggio di errore nella snackbar
      return '';
    }

  } 
}
