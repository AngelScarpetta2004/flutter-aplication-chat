import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final Function(String) onSendMessage; // Función para enviar el mensaje
  final TextEditingController
      textController; // Controlador para el campo de texto

  const MessageFieldBox({
    super.key,
    required this.onSendMessage,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    // FocusNode para gestionar el foco del campo de texto
    final focusNode = FocusNode();

    // Estilos del campo de texto
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Digite la clave',

      // Estilos para el campo de texto
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,

      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          final textValue = textController.text;
          if (textValue.isNotEmpty) {
            onSendMessage(
                textValue); // Llamar a la función para enviar el mensaje
          }
        },
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: TextFormField(
        // Al dar clic fuera del campo de texto, cerrar el teclado
        onTapOutside: (event) {
          focusNode.unfocus();
        },

        // Asociar el foco al campo de texto
        focusNode: focusNode,

        // Inicialización del controlador
        controller: textController,

        // Aplicación de estilos de la decoración
        decoration: inputDecoration,

        // Acción al enviar el formulario (presionar enter)
        onFieldSubmitted: (value) {
          if (value.isNotEmpty) {
            onSendMessage(value); // Llamar a la función para enviar el mensaje
            textController.clear(); // Limpiar el campo después de enviar
          }
        },
      ),
    );
  }
}
