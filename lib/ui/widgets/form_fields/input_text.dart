import 'package:flutter/material.dart';
import 'input_wrap.dart';

class InputText extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String initValue;
  final int maxLines;
  final int minLines;
  final double marginBottom;
  final bool enabled;
  final bool readOnly;
  final bool required;
  final TextInputType keyboardType;
  final Widget icon;
  final Function onIconTap;
  final Function(String value) onSaved;
  final Function(String value) onChanged;
  final String Function(String) validator;

  InputText({
    this.labelText,
    this.hintText,
    this.initValue,
    this.keyboardType = TextInputType.emailAddress,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.onSaved,
    this.onChanged,
    this.icon,
    this.onIconTap,
    this.validator,
    this.marginBottom,
  });

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  String error = '';

  bool get hasError => error.isNotEmpty;

  String _validator(String value) {
    if (widget.validator != null) {
      String result = widget.validator(value);

      if (result != null) {
        setState(() {
          error = result;
        });

        return '';
      }

      setState(() {
        error = '';
      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InputWrap(
      marginBottom: widget.marginBottom,
      child: Stack(
        children: <Widget>[
          TextFormField(
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            validator: _validator,
            readOnly: widget.readOnly,
            initialValue: widget.initValue,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            style: TextStyle(fontSize: 14),
            onSaved: widget.onSaved,
            decoration: new InputDecoration(
              suffixIcon: _icon(),
              labelText: _labelText(),
              labelStyle: TextStyle(
                  fontSize: 14,
                  color: hasError
                      ? Theme.of(context).errorColor
                      : Colors.black.withOpacity(0.34)),
              hintText: widget.hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  String _labelText() {
    if (!hasError) {
      return widget.labelText;
    }

    return error;
  }

  Widget _icon() {
    if (widget.icon != null) {
      return IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        iconSize: 24,
        padding: EdgeInsets.zero,
        onPressed: widget.onIconTap ?? () => null,
        icon: widget.icon,
      );
    }

    return null;
  }
}
