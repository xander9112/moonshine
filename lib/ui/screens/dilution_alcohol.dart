import 'package:calc/core/translation_service.dart';
import 'package:calc/core/utils/index.dart';
import 'package:calc/core/validators.dart';
import 'package:calc/ui/widgets/form_fields/index.dart';
import 'package:flutter/material.dart';

class DilutionAlcohol extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final String title = 'dilutionAlcohol.title';

  @override
  _DilutionAlcoholState createState() => _DilutionAlcoholState();
}

class _DilutionAlcoholState extends State<DilutionAlcohol> {
  final TranslationService _translationService = TranslationService();
  final List<Map<String, dynamic>> _formFieldsMap = [
    {
      'name': 'temperature',
      'validator': Validators.validate(
          [Validators.required, Validators.min(0), Validators.max(100)]),
    },
    {
      'name': 'spiritualityStart',
      'validator': Validators.validate([Validators.required]),
    },
    {
      'name': 'spiritualityFinish',
      'validator': Validators.validate([Validators.required]),
    },
    {
      'name': 'capacity',
      'validator': Validators.validate([Validators.required]),
    }
  ];

  final Map<String, dynamic> _formFields = {
    "temperature": "20",
    "spiritualityStart": "",
    "spiritualityFinish": "",
    "capacity": "",
  };

  String result = '';

  Future<void> _onSubmit() async {
    if (DilutionAlcohol._formKey.currentState.validate()) {
      DilutionAlcohol._formKey.currentState.save();

      setState(() {
        double spirituality = temperatureCorrection(
            int.parse(_formFields['spiritualityStart']),
            int.parse(_formFields['temperature']));

        result = dilutionAlcohol(
                spirituality.round(),
                int.parse(_formFields['capacity']),
                int.parse(_formFields['spiritualityFinish']))
            .toString();
      });

      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  _onSave(String name) => (String value) {
        setState(() {
          _formFields[name] = value;
        });
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: DilutionAlcohol._formKey,
        child: Column(
          children: <Widget>[
            ..._formFieldsMap
                .map(
                  (field) => InputRow(
                    children: <Widget>[
                      InputText(
                        marginBottom: 0,
                        keyboardType: TextInputType.number,
                        initValue: _formFields[field['name']],
                        validator: field['validator'],
                        labelText: _translationService
                            .text('dilutionAlcohol.fields.${field['name']}'),
                        hintText: _translationService
                            .text('dilutionAlcohol.fields.${field['name']}'),
                        onSaved: _onSave(field['name']),
                      ),
                    ],
                  ),
                )
                .toList(),
            Expanded(
              child: _result(),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: _onSubmit,
                child: Text(_translationService.text('common.submit')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _result() {
    if (result.isEmpty) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            '$result ${_translationService.text('common.ml')}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            _translationService.text('dilutionAlcohol.result'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    );
  }
}
