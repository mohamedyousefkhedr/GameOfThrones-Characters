import '../api/characters_api.dart';
import '../models/characters.dart';

class CharacterRepo {
  final CharactersApi charactersApi;

  CharacterRepo(this.charactersApi);
  Future<List<Character>> getCharacters() async {
    final characters = await charactersApi.getCharacters();
    return characters.map((character) => Character.fromJson(character)).toList(); 
  }
}
