import 'package:calc/core/translation_service.dart';
import 'package:calc/core/utils/index.dart';
import 'package:calc/core/validators.dart';
import 'package:calc/ui/widgets/form_fields/index.dart';
import 'package:flutter/material.dart';

class CorrectionByTemperature extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _CorrectionByTemperatureState createState() =>
      _CorrectionByTemperatureState();
}

class _CorrectionByTemperatureState extends State<CorrectionByTemperature> {
  TranslationService _translationService = TranslationService();

  Map<String, dynamic> _formFields = {
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
      appBar: AppBar(
        title: Text(_translationService.text('correctionByTemperature.title')),
      ),
      body: Form(
        key: CorrectionByTemperature._formKey,
        child: ListView(
          children: <Widget>[
            InputRow(
              children: <Widget>[
                InputText(
                  marginBottom: 0,
                  keyboardType: TextInputType.number,
                  initValue: _formFields['temperature'],
                  validator: Validators.validate([
                    Validators.required,
                    Validators.min(0),
                    Validators.max(100)
                  ]),
                  labelText: _translationService
                      .text('correctionByTemperature.fields.temperature'),
                  onSaved: _onSave('temperature'),
                ),
              ],
            ),
            InputRow(
              children: <Widget>[
                InputText(
                  marginBottom: 0,
                  initValue: _formFields['spirituality'],
                  keyboardType: TextInputType.number,
                  validator: Validators.validate([Validators.required]),
                  labelText: _translationService
                      .text('correctionByTemperature.fields.spirituality'),
                  onSaved: _onSave('spirituality'),
                ),
              ],
            ),
            RaisedButton(
              onPressed: _onSubmit,
              child: Text(_translationService.text('common.submit')),
            ),
            _result(),
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
