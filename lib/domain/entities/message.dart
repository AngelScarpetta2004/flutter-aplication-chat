// Crear la variable de tipo enumeración
enum FromWho { mine, hers }

// Clase Message para capturar el mensaje
class Message {
  final String text;
  final String? imageUrl; // Cambié 'imagenUrl' a 'imageUrl' para mayor claridad
  final FromWho fromWho; // Cambié 'fronWho' a 'fromWho' para corregir el nombre

  // Constructor para inicializar los valores
  Message(this.text, this.imageUrl, this.fromWho);
}
