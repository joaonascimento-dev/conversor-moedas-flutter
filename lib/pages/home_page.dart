import 'package:flutter/material.dart';
import 'package:conversor_moedas_flutter/repositories/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Repository repo = Repository();
  late double dolar;
  late double euro;
  late double iene;

  TextEditingController controllerReal = TextEditingController();
  TextEditingController controllerDolar = TextEditingController();
  TextEditingController controllerEuro = TextEditingController();
  TextEditingController controllerIene = TextEditingController();

  void _limparCampos() {
    controllerReal.text = "";
    controllerDolar.text = "";
    controllerEuro.text = "";
    controllerIene.text = "";
  }

  void _realChanged(String texto) {
    if (texto.isEmpty) {
      _limparCampos();
      return;
    }

    double real = double.parse(texto);
    controllerDolar.text = (real / dolar).toStringAsFixed(2);
    controllerEuro.text = (real / euro).toStringAsFixed(2);
    controllerIene.text = (real / iene).toStringAsFixed(2);
  }

  void _dolarChanged(String texto) {
    if (texto.isEmpty) {
      _limparCampos();
      return;
    }

    double valorDolar = double.parse(texto);
    controllerReal.text = (valorDolar * dolar).toStringAsFixed(2);
    controllerEuro.text = ((valorDolar * dolar) / euro).toStringAsFixed(2);
    controllerIene.text = ((valorDolar * dolar) / iene).toStringAsFixed(2);
  }

  void _euroChanged(String texto) {
    if (texto.isEmpty) {
      _limparCampos();
      return;
    }

    double valorEuro = double.parse(texto);
    controllerReal.text = (valorEuro * euro).toStringAsFixed(2);
    controllerDolar.text = ((valorEuro * euro) / dolar).toStringAsFixed(2);
    controllerIene.text = ((valorEuro * euro) / iene).toStringAsFixed(2);
  }

  void _ieneChanged(String texto) {
    if (texto.isEmpty) {
      _limparCampos();
      return;
    }

    double valorIene = double.parse(texto);
    controllerReal.text = (valorIene * iene).toStringAsFixed(2);
    controllerDolar.text = ((valorIene * iene) / dolar).toStringAsFixed(2);
    controllerEuro.text = ((valorIene * iene) / euro).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    Color fundo = const Color.fromRGBO(37, 37, 37, 1);

    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        title: const Text(
          "\$ Conversor de Moedas \$",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.monetization_on_outlined,
              size: 150,
              color: Colors.deepPurple,
            ),
            FutureBuilder(
                future: repo.getDados(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: Text(
                          "Carregando Dados...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            "Erro na Conexão!!!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        dolar = snapshot.data?["results"]["currencies"]["USD"]
                            ["buy"];
                        euro = snapshot.data?["results"]["currencies"]["EUR"]
                            ["buy"];
                        iene = snapshot.data?["results"]["currencies"]["JPY"]
                            ["buy"];

                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TextField(
                                controller: controllerReal,
                                decoration: const InputDecoration(
                                  label: Text("Real (BRL)"),
                                  prefix: Text(
                                    "R\$",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: _realChanged,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              ),
                              TextField(
                                controller: controllerDolar,
                                decoration: const InputDecoration(
                                  label: Text("Dolar (USD)"),
                                  prefix: Text(
                                    "US\$",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: _dolarChanged,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              ),
                              TextField(
                                controller: controllerEuro,
                                decoration: const InputDecoration(
                                  label: Text("Euro (EUR)"),
                                  prefix: Text(
                                    "€",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: _euroChanged,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              ),
                              TextField(
                                controller: controllerIene,
                                decoration: const InputDecoration(
                                  label: Text("Iene (JPY)"),
                                  prefix: Text(
                                    "¥",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: _ieneChanged,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              )
                            ],
                          ),
                        );
                      }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
