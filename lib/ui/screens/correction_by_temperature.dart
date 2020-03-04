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
  Future<void> _onSubmit() async {
    print(CorrectionByTemperature._formKey.currentState.validate());
    if (CorrectionByTemperature._formKey.currentState.validate()) {
      CorrectionByTemperature._formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: CorrectionByTemperature._formKey,
        child: ListView(
          children: <Widget>[
            InputRow(
              children: <Widget>[
                InputText(
                  marginBottom: 0,
                  labelText: 'dasdasda',
                  hintText: 'dasdas',
                  onSaved: (value) {
                    // contact.skype = value;
                  },
                ),
              ],
            ),
            InputRow(
              children: <Widget>[
                InputText(
                  marginBottom: 0,
                  labelText: '123',
                  hintText: 'dasdas',
                  validator: Validators.validate([Validators.required]),
                  onSaved: (value) {
                    // contact.skype = value;
                  },
                ),
              ],
            ),
            RaisedButton(
              onPressed: () => _onSubmit(),
              child: Text('suib'),
            )
          ],
        ),
      ),
    );
  }
}
