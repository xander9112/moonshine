import 'package:calc/core/translation_service.dart';
import 'package:calc/core/utils/index.dart';
import 'package:calc/core/validators.dart';
import 'package:calc/ui/widgets/form_fields/index.dart';
import 'package:flutter/material.dart';

class VolumeSugar extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final String title = 'volumeSugar.title';

  @override
  _VolumeSugarState createState() => _VolumeSugarState();
}

class _VolumeSugarState extends State<VolumeSugar> {
  final TranslationService _translationService = TranslationService();

  final List<Map<String, dynamic>> _formFieldsMap = [
    {
      'name': 'amount',
      'validator': Validators.validate([Validators.required]),
    },
    {
      'name': 'capacity',
      'validator': Validators.validate([Validators.required]),
    }
  ];

  final Map<String, dynamic> _formFields = {
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
      body: Form(
        key: VolumeSugar._formKey,
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
                            .text('volumeSugar.fields.${field['name']}'),
                        hintText: _translationService
                            .text('volumeSugar.fields.${field['name']}'),
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
            _translationService.text('volumeSugar.result'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    );
  }
}
