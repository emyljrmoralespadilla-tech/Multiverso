import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/character_model.dart';
import '../providers/character_provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<CharacterProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Mis favoritos")),
      body: FutureBuilder<List<Character>>(
        future: ApiService().getCharacters(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final favIds = favProvider.favourites;
          final favourites = snapshot.data!
              .where((character) => favIds.contains(character.id))
              .toList();

          if (favourites.isEmpty) {
            return const Center(
              child: Text(
                "No tienes personajes favoritos todavía",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final char = favourites[index];
              return ListTile(
                leading: Image.network(char.image),
                title: Text(char.name),
                subtitle: Text(char.status),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    favProvider.toggleFavourite(char.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
