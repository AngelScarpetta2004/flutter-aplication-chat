import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/presentation/widgets/chat/my_message_bubble.dart';
import 'package:flutter_application_1/presentation/widgets/chat/other_message_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://th.bing.com/th/id/OIP.TZsYS0Ygg_ITt5HAJOoJcQHaNF?rs=1&pid=ImgDetMain',
            ),
          ),
        ),
        title: const Text('Angel Chat 💻'),
        centerTitle: true,
      ),
      body: const _ChatView(), // Lógica principal separada en _ChatView
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({super.key});

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages =
      []; // Lista para almacenar mensajes

  /// Envía un mensaje y maneja las respuestas según sea necesario.
  Future<void> _sendMessage(String message) async {
    if (message.isEmpty) return; // Validación para evitar mensajes vacíos

    // Agregar mensaje del usuario
    setState(() {
      messages.add({
        'text': message,
        'from': 'mine',
      });
    });

    // Verificar si el mensaje contiene "?" y llamar a la API
    if (message.contains('?')) {
      try {
        final response = await http.get(Uri.parse('https://yesno.wtf/api'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            messages.add({
              'text': data['answer'], // Respuesta de la API
              'from': 'hers',
              'image': data['image'], // Imagen de la API
            });
          });
        } else {
          _addErrorMessage('Error al obtener respuesta de la API.');
        }
      } catch (e) {
        _addErrorMessage('Error: No se pudo completar la solicitud.');
      }
    } else {
      _addRandomResponse();
    }

    _controller.clear(); // Limpiar el campo de texto
  }

  /// Agrega un mensaje de error en la lista.
  void _addErrorMessage(String errorMessage) {
    setState(() {
      messages.add({
        'text': errorMessage,
        'from': 'hers',
      });
    });
  }

  /// Genera una respuesta aleatoria si el mensaje no contiene "?".
  void _addRandomResponse() {
    const randomResponses = [
      'No entiendo lo que preguntas.',
      '¿Podrías reformular?',
      'Eso no parece una pregunta.',
      'Hmmm, no estoy seguro de cómo responder a eso.',
      'Intenta preguntar algo diferente.',
    ];

    final randomResponse =
        randomResponses[Random().nextInt(randomResponses.length)];
    setState(() {
      messages.add({
        'text': randomResponse,
        'from': 'hers',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Lista de mensajes
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              if (message['from'] == 'mine') {
                return MyMessageBubble(message: message['text']);
              } else {
                return OtherMessageBubble(
                  message: message['text'],
                  imageUrl: message['image'], // Imagen opcional
                );
              }
            },
          ),
        ),
        // Campo de texto para enviar mensajes
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Campo de entrada de texto
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Escribe un mensaje...',
                  ),
                  onSubmitted: (text) {
                    if (text.trim().isNotEmpty) {
                      _sendMessage(text.trim());
                    }
                  },
                ),
              ),
              // Botón de enviar
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    _sendMessage(text);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
