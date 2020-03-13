import 'package:calc/core/translation_service.dart';
import 'package:calc/core/utils/index.dart';
import 'package:calc/core/validators.dart';
import 'package:calc/ui/widgets/form_fields/index.dart';
import 'package:flutter/material.dart';

class CorrectionByTemperature extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final String title = 'correctionByTemperature.title';

  @override
  _CorrectionByTemperatureState createState() =>
      _CorrectionByTemperatureState();
}

class _CorrectionByTemperatureState extends State<CorrectionByTemperature> {
  final TranslationService _translationService = TranslationService();

  final List<Map<String, dynamic>> _formFieldsMap = [
    {
      'name': 'temperature',
      'validator': Validators.validate(
          [Validators.required, Validators.min(0), Validators.max(100)]),
    },
    {
      'name': 'spirituality',
      'validator': Validators.validate([Validators.required]),
    }
  ];

  final Map<String, dynamic> _formFields = {
    "temperature": "20",
    "spirituality": "",
  };
  String result = '';
  Future<void> _onSubmit() async {
    if (CorrectionByTemperature._formKey.currentState.validate()) {
      CorrectionByTemperature._formKey.currentState.save();

      setState(() {
        result = temperatureCorrection(int.parse(_formFields['spirituality']),
                int.parse(_formFields['temperature']))
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
        key: CorrectionByTemperature._formKey,
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
                        labelText: _translationService.text(
                            'correctionByTemperature.fields.${field['name']}'),
                        hintText: _translationService.text(
                            'correctionByTemperature.fields.${field['name']}'),
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
            _translationService.text('correctionByTemperature.result'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '$result %',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    );
  }
}
