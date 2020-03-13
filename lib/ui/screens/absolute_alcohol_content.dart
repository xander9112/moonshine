import 'package:calc/core/translation_service.dart';
import 'package:calc/core/utils/index.dart';
import 'package:calc/core/validators.dart';
import 'package:calc/ui/widgets/form_fields/index.dart';
import 'package:flutter/material.dart';

class AbsoluteAlcoholContent extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _AbsoluteAlcoholContentState createState() => _AbsoluteAlcoholContentState();
}

class _AbsoluteAlcoholContentState extends State<AbsoluteAlcoholContent> {
  TranslationService _translationService = TranslationService();

  Map<String, dynamic> _formFields = {
    "temperature": "20",
    "spirituality": "",
    "capacity": "",
  };

  String result = '';

  Future<void> _onSubmit() async {
    if (AbsoluteAlcoholContent._formKey.currentState.validate()) {
      AbsoluteAlcoholContent._formKey.currentState.save();

      setState(() {
        double spirituality = temperatureCorrection(
            int.parse(_formFields['spirituality']),
            int.parse(_formFields['temperature']));

        result = absoluteAlcoholContent(
                int.parse(_formFields['capacity']), spirituality.round())
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
        title: Text(_translationService.text('absoluteAlcoholContent.title')),
      ),
      body: Form(
        key: AbsoluteAlcoholContent._formKey,
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
                      .text('absoluteAlcoholContent.fields.temperature'),
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
                      .text('absoluteAlcoholContent.fields.spirituality'),
                  onSaved: _onSave('spirituality'),
                ),
              ],
            ),
            InputRow(
              children: <Widget>[
                InputText(
                  marginBottom: 0,
                  initValue: _formFields['capacity'],
                  keyboardType: TextInputType.number,
                  validator: Validators.validate([Validators.required]),
                  labelText: _translationService
                      .text('absoluteAlcoholContent.fields.capacity'),
                  onSaved: _onSave('capacity'),
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
            _translationService.text('absoluteAlcoholContent.result'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '$result ${_translationService.text('common.ml')}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    );
  }
}
