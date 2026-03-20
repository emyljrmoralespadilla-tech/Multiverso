import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class ApiService {

  Future<List<Character>> getCharacters() async {

    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character')
    );

    final data = jsonDecode(response.body);

    List characters = data['results'];

    return characters
        .map((json) => Character.fromJson(json))
        .toList();
  }
}