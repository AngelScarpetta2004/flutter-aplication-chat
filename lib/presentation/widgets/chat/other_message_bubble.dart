import 'package:flutter/material.dart';

class OtherMessageBubble extends StatelessWidget {
  final String message;
  final String? imageUrl; // Imagen opcional

  const OtherMessageBubble({
    super.key,
    required this.message,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null) // Mostrar imagen si existe
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image.network(
                imageUrl!,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
