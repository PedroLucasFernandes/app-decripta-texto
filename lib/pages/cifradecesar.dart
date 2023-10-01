import 'package:flutter/material.dart';

class CesarPage extends StatefulWidget {
  @override
  _CesarPageState createState() => _CesarPageState();
}

class _CesarPageState extends State<CesarPage> {
  final TextEditingController _textEditingController = TextEditingController();
  int _selectedDeslocamento = 3; 
  String _textoDecifrado = "";

  String decifrarCesar(String textoCriptografado, int deslocamento) {
  String textoDecifrado = "";

  for (int i = 0; i < textoCriptografado.length; i++) {
    final char = textoCriptografado[i];
    if (char != ' ') {
      final codigo = char.codeUnitAt(0);
      int novoCodigo;

      if (codigo >= 'A'.codeUnitAt(0) && codigo <= 'Z'.codeUnitAt(0)) {
        novoCodigo = (codigo - deslocamento - 'A'.codeUnitAt(0)) % 26 + 'A'.codeUnitAt(0);
      } else if (codigo >= 'a'.codeUnitAt(0) && codigo <= 'z'.codeUnitAt(0)) {
        novoCodigo = (codigo - deslocamento - 'a'.codeUnitAt(0)) % 26 + 'a'.codeUnitAt(0);
      } else {
        novoCodigo = codigo;
      }

      final novoChar = String.fromCharCode(novoCodigo);
      textoDecifrado += novoChar;
    } else {
      textoDecifrado += ' ';
    }
  }

  return textoDecifrado;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cifra de César",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: "Digite o texto:",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20,),
            DropdownButton<int>(
              value: _selectedDeslocamento,
              items: List.generate(26, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text("ROT ${index + 1}"),
                );
              }),
              onChanged: (value) {
                setState(() {
                  _selectedDeslocamento = value!;
                });
              },
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                final textoCriptografado = _textEditingController.text;
                final textoDecifrado = decifrarCesar(textoCriptografado, _selectedDeslocamento);
                setState(() {
                  _textoDecifrado = textoDecifrado;
                });
              },
              child: Text("Descriptografar"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                final textoCriptografado = _textEditingController.text;
                final textoDecifrado = decifrarCesar(textoCriptografado, - _selectedDeslocamento);
                setState(() {
                  _textoDecifrado = textoDecifrado;
                });
              },
              child: Text("Criptografar"),
            ),
            SizedBox(height: 30,),
            Text(
              "Resultado:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(80.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _textoDecifrado,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
            },
            child: Text("Voltar ao menu inicial")
            ),
          ],
        ),
      ),
    );
  }
}