import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business-logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'presentation/screens/character_details.dart';
import 'presentation/screens/characters.dart';

import 'data/api/characters_api.dart';
import 'data/models/characters.dart';
import 'data/repo/characters_repo.dart';

class AppRouter {
  late CharacterRepo characterRepo;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepo = CharacterRepo(CharactersApi());
    charactersCubit = CharactersCubit(characterRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(characterRepo),
            child: const CharactersScreen(),
          ),
        );
        case characterDetailsScreen:
        final character = settings.arguments as Character;
        
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(characterRepo),
            child: CharacterDetailsScreen(
              character: character,
            ),
          ),
        );
    }
    return MaterialPageRoute(builder: (_)=>const Text('404 Not Found'));
  }
}