 import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/characters_repo.dart';
 
import '../../data/models/characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepo characterRepo;
  List<Character> characters=[];
  CharactersCubit(this.characterRepo) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    characterRepo.getCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters ; 
  }
}
