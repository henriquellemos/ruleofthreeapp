import 'package:flutter/material.dart';

void main() => runApp(RuleOfTree());

class RuleOfTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RuleOfThree",
      theme: ThemeData(primaryColor: Colors.orange),
      home: Home(title: "Rule of Three"),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController variableXController = TextEditingController();
  TextEditingController variableYController = TextEditingController();
  TextEditingController variableZController = TextEditingController();

  String _responseCalculate = "X";

  @override
  Widget build(BuildContext context) {
    bool _isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    String _validateField(value) {
      if (value.isEmpty) {
        return "Field with value empty!";
      } else if (!_isNumeric(value)) {
        return "Not a number!";
      }
    }

    final textInfo = new Container(
      width: 500,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.orange[200],
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        "Fill the values",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black54,
        ),
      ),
    );

    final textX = new Container(
      width: 500,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.orange[500],
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Text(
        "$_responseCalculate",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black54,
        ),
      ),
    );

    final textFieldX = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Value X',
        hintText: '2.0',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: variableXController,
      validator: (value) {
        print(value);
        return _validateField(value);
      },
    );

    final textFieldY = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Value Y',
        hintText: '10.0',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: variableYController,
      validator: (value) {
        print(value);
        return _validateField(value);
      },
    );

    final textFieldZ = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Value Z',
        hintText: '5.0',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: variableZController,
      validator: (value) {
        print(value);
        return _validateField(value);
      },
    );

    final iconBetweenWidgets = const Icon(Icons.settings_ethernet);

    double _calculateRule(String x, String y, String z) {
      double result = 0;
      print(double.parse(x));
      print(double.parse(y));
      print(double.parse(z));
      result = (double.parse(y) * double.parse(z)) / double.parse(x);
      return result;
    }

    void _resetFields() {
      setState(() {
        variableXController.text = "";
        variableYController.text = "";
        variableZController.text = "";
        _responseCalculate = "X";
        _globalKey = GlobalKey<FormState>();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rule of Three"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: Center(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 100.0),
                child: Icon(
                  Icons.swap_horizontal_circle,
                  size: 100.0,
                  color: Colors.orange,
                ),
              ),
              textInfo,
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(flex: 4, child: textFieldX),
                    Flexible(
                      flex: 2,
                      child: iconBetweenWidgets,
                    ),
                    Flexible(flex: 4, child: textFieldY),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(flex: 4, child: textFieldZ),
                    Flexible(flex: 2, child: iconBetweenWidgets),
                    Flexible(
                      flex: 4,
                      child: Center(
                        child: textX,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange[700],
        label: Text(
          "Calculate",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black45,
          ),
        ),
        onPressed: () => setState(() {
          if (_globalKey.currentState.validate())
            _responseCalculate = _calculateRule(variableXController.text,
                    variableYController.text, variableZController.text)
                .toString();
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
