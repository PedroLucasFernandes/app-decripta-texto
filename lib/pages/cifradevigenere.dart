import 'package:flutter/material.dart';

class VigenerePage extends StatefulWidget {
  @override
  _VigenerePageState createState() => _VigenerePageState();
}

class _VigenerePageState extends State<VigenerePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _chaveEditingController = TextEditingController();
  String _resultado = "";

  String cifraVigenere(String texto, String chave, bool criptografar) {
    String resultado = "";
    int chaveIndex = 0;

    for (int i = 0; i < texto.length; i++) {
      final charTexto = texto[i];
      final codigoTexto = charTexto.codeUnitAt(0);

      if (codigoTexto >= 'A'.codeUnitAt(0) && codigoTexto <= 'Z'.codeUnitAt(0)) {
        final charChave = chave[chaveIndex % chave.length];
        final codigoChave = charChave.codeUnitAt(0);

        int novoCodigo;

        if (criptografar) {
          novoCodigo = (codigoTexto + codigoChave - 2 * 'A'.codeUnitAt(0)) % 26 + 'A'.codeUnitAt(0);
        } else {
          novoCodigo = (codigoTexto - codigoChave + 26) % 26 + 'A'.codeUnitAt(0);
        }

        final novoChar = String.fromCharCode(novoCodigo);
        resultado += novoChar;
        chaveIndex++;
      } else if (codigoTexto >= 'a'.codeUnitAt(0) && codigoTexto <= 'z'.codeUnitAt(0)) {
        final charChave = chave[chaveIndex % chave.length].toLowerCase();
        final codigoChave = charChave.codeUnitAt(0);

        int novoCodigo;

        if (criptografar) {
          novoCodigo = (codigoTexto + codigoChave - 2 * 'a'.codeUnitAt(0)) % 26 + 'a'.codeUnitAt(0);
        } else {
          novoCodigo = (codigoTexto - codigoChave + 26) % 26 + 'a'.codeUnitAt(0);
        }

        final novoChar = String.fromCharCode(novoCodigo);
        resultado += novoChar;
        chaveIndex++;
      } else {
        resultado += charTexto;
      }
    }

    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cifra de Vigenère",
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
            TextFormField(
              controller: _chaveEditingController, // Adicione este controller
              decoration: InputDecoration(
                labelText: "Digite a chave:",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                final texto = _textEditingController.text;
                final chave = _chaveEditingController.text;
                final resultado = cifraVigenere(texto, chave, false); // Defina como true para criptografar
                setState(() {
                  _resultado = resultado;
                });
              },
              child: Text("Descriptografar"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                final texto = _textEditingController.text;
                final chave = _chaveEditingController.text;
                final resultado = cifraVigenere(texto, chave, true); // Defina como false para descriptografar
                setState(() {
                  _resultado = resultado;
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
                _resultado,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(
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