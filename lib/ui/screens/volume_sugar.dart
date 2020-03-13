import 'package:calc/core/translation_service.dart';
import 'package:calc/core/utils/index.dart';
import 'package:calc/core/validators.dart';
import 'package:calc/ui/widgets/form_fields/index.dart';
import 'package:flutter/material.dart';

class VolumeSugar extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _VolumeSugarState createState() => _VolumeSugarState();
}

class _VolumeSugarState extends State<VolumeSugar> {
  TranslationService _translationService = TranslationService();

  Map<String, dynamic> _formFields = {
    "amount": "",
    "capacity": "",
  };

  String result = '';

  Future<void> _onSubmit() async {
    if (VolumeSugar._formKey.currentState.validate()) {
      VolumeSugar._formKey.currentState.save();

      setState(() {
        result = volumeSugar(
          int.parse(_formFields['amount']),
          int.parse(_formFields['capacity']),
        ).round().toString();
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
      appBar: AppBar(
        title: Text(_translationService.text('volumeSugar.title')),
      ),
      body: Form(
        key: VolumeSugar._formKey,
        child: ListView(
          children: <Widget>[
            InputRow(
              children: <Widget>[
                InputText(
                  keyboardType: TextInputType.number,
                  initValue: _formFields['amount'],
                  validator: Validators.validate([
                    Validators.required,
                    Validators.min(0),
                    Validators.max(100)
                  ]),
                  labelText:
                      _translationService.text('volumeSugar.fields.amount'),
                  onSaved: _onSave('amount'),
                ),
              ],
            ),
            InputRow(
              children: <Widget>[
                InputText(
                  initValue: _formFields['capacity'],
                  keyboardType: TextInputType.number,
                  validator: Validators.validate([Validators.required]),
                  labelText:
                      _translationService.text('volumeSugar.fields.capacity'),
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
            '$result ${_translationService.text('common.ml')}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            _translationService.text('volumeSugar.result'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    );
  }
}
