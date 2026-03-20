import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/character_model.dart';
import '../providers/character_provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<CharacterProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Explorar Personajes")),

      body: FutureBuilder<List<Character>>(
        future: ApiService().getCharacters(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final characters = snapshot.data!;

          return ListView.builder(
            itemCount: characters.length,

            itemBuilder: (context, index) {
              final c = characters[index];
              final isFav = favProvider.isFavourite(c.id);

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(c.image),
                  radius: 28,
                ),
                title: Text(
                  c.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(c.status),
                trailing: IconButton(
                  iconSize: 34,
                  color: isFav ? Colors.redAccent : Colors.grey[700],
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                  splashRadius: 28,
                  onPressed: () => favProvider.toggleFavourite(c.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
