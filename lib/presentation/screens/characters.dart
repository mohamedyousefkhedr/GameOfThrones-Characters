import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../business-logic/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> charactersList;
  late List<Character> searchedCharactersList;
  bool _isSearching = false;
  final _searchController = TextEditingController();
  Widget _buildSearchField() {
    return TextField(
      style: const TextStyle(fontSize: 18, color: MyColors.greyColor),
      onChanged: (searchedCharacter) {
        searchProcess(searchedCharacter);
      },
      controller: _searchController,
      cursorColor: MyColors.greyColor,
      decoration: const InputDecoration(
          hintText: 'Find Your Charcter',
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 18, color: MyColors.greyColor)),
    );
  }

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    super.initState();
  }
List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: MyColors.greyColor),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.greyColor,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }
  void searchProcess(String searchedCharacter) {
    searchedCharactersList = charactersList.where((character) =>
        character.fullName.toLowerCase().startsWith(searchedCharacter)).toList();
        setState(() {
          
        });
  }

  Widget buildMainWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        charactersList = (state).characters;
        return buildLodedWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildLodedWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.greyColor,
        child: Column(
          children: <Widget>[buildCharactersList()],
        ),
      ),
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.yellowColor,
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(





        itemCount: _searchController.text.isEmpty? charactersList.length:searchedCharactersList.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2 ,
          childAspectRatio: 1
        ),
        itemBuilder: (ctxt, index) {
          return CharacterItem(
            character: _searchController.text.isEmpty
              ? charactersList[index]
              : searchedCharactersList[index],
          );
        });
  }
   Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.greyColor),
    );
  }
Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const  SizedBox(
              height: 20,
            ),
          const   Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.greyColor,
              ),
            ),
            Image.asset('assets/images/no-internet.gif')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:MyColors.greyColor ,
      appBar: AppBar(
        backgroundColor: MyColors.yellowColor,
        leading: _isSearching
            ? const BackButton(
                color: MyColors.greyColor,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
       body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildMainWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
