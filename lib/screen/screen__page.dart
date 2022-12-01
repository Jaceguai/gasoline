import 'package:flutter/material.dart';


class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  String? alcool;
  String? gasolina;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController? gasolinaController = TextEditingController();
  TextEditingController? alcoolController = TextEditingController();

  String _infoText = "Informe o valor de cada combustível";

  void _resetFields() {
    gasolinaController!.text = "";
    alcoolController!.text = "";
    setState(() {
      _infoText = "Informe o valor de cada combustível";
      _formkey = GlobalKey<FormState>();
    });
  }

  void calcula() {
    setState(() {
      double gasolina = double.parse(gasolinaController!.text);
      double alcool = double.parse(alcoolController!.text);
      double resultado = (alcool / gasolina);

      if (resultado > 0.70) {
        _infoText =
            "Percentual : (${resultado.toStringAsPrecision(3)})\n\nVale a pena abastecer com Gasolina";
      } else {
        _infoText =
            "Percentual : (${resultado.toStringAsPrecision(3)})\n\nVale a pena abastecer com Etanol";
      }
    });
  }

  Text buildTextInfo() {
    return Text(_infoText,
        textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.black, fontSize: 20.0));
  }

  buildTextFormFieldGasolina() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Digite o preço da Gasolina",
        hintText: "Somente números",
        suffixIcon: Icon(Icons.local_gas_station_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
      controller: gasolinaController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe o valor da gasolina';
        }
        return null;
      },
    );
  }

  buildTextFormFieldAlcool() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Digite o preço do Etanol",
        hintText: "Somente números",
        suffixIcon: Icon(Icons.local_gas_station_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
      controller: alcoolController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe o valor do Etanol';
        }
        return null;
      },
    );
  }

  Container buildContainerButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 60.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all(Colors.blue[800]),
        ) ,
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            calcula();
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        child: const Text("Calcular",
            style: TextStyle(color: Colors.white, fontSize: 20.0,)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.yellow[700]!, Colors.blue[800]!])),
        ),
        actions: [
          IconButton(
              onPressed: (() {
                _resetFields();
              }),
              icon: const Icon(Icons.refresh))
        ],
        title: const Text(
          "Calculadora de Combustível",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
        child: Form(
          key: _formkey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Icon(Icons.directions_car, size: 80.0, color: Colors.yellow[700]),
            const SizedBox(
              height: 20,
            ),
            buildTextFormFieldGasolina(),
            const SizedBox(height: 10),
            buildTextFormFieldAlcool(),
            buildContainerButton(context),
            const SizedBox(
              height: 10,
            ),
            Center(child: buildTextInfo()),
           const SizedBox(height: 250,),
         const Text("By Jaceguai Júnior <3",
          style: TextStyle(fontSize: 12),)
          ]),
        ),
      ),
    );
  }
}
