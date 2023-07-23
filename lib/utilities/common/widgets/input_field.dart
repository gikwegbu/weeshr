// ignore_for_file: constant_identifier_names

import 'package:weeshr/utilities/constant/exported_packages.dart';

const FORM_STYLE = TextStyle(color: GREY, fontSize: 15);

class FormUtils {
  static InputDecoration formDecoration({
    String? labelText,
    String? helperText,
    Widget? suffix,
    Widget? prefix,
    String? hintText,
    String? suffixText,
    Widget? suffixIcon,
    bool isLoading = false,
    double? horizontalPadding,
    double? verticalPadding,
    Widget? prefixIcon,
    bool enabled = true,
    TextStyle? counterStyle,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 14.0),
      helperText: helperText,
      helperStyle: const TextStyle(fontSize: 14.0),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14.0),
      suffix: suffix,
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(maxWidth: 30),
      prefix: prefix,
      alignLabelWithHint: true,
      enabled: enabled,
      suffixText: suffixText,
      suffixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.transparent, width: 1),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.transparent, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: alertError['Base']!, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: PRIMARY, width: 1),
      ),
      errorStyle: TextStyle(fontSize: 14.0, color: alertError['Base']),
      filled: true,
      fillColor: GREY_50,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 22,
        vertical: verticalPadding ?? 16,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: alertError['Base']!,
        ),
      ),
      counterStyle: counterStyle,
    );
  }

  static InputDecoration pinInputDecoration() {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    );
    return const InputDecoration(
      errorStyle: TextStyle(
        fontSize: 14.0,
      ),
      border: border,
      focusedErrorBorder: border,
      contentPadding: EdgeInsets.all(0),
      enabledBorder: border,
      counterText: "",
      enabled: false,
      errorBorder: border,
      focusedBorder: border,
    );
  }

  static Widget formSpacer() {
    return const SizedBox(
      height: 16.0,
    );
  }
}

class FormLabel extends StatefulWidget {
  final String label;
  final Color? color;
  final String? hint;

  const FormLabel({Key? key, required this.label, this.color, this.hint})
      : super(key: key);

  @override
  _FormLabelState createState() => _FormLabelState();
}

class _FormLabelState extends State<FormLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            subtext(
              widget.label,
              fontSize: 13,
              color: widget.color ?? GREY_50,
              fontWeight: FontWeight.w600,
            ),
            xSpace(width: 8),
          ],
        ),
      ],
    );
  }
}

class SectionDivider extends StatelessWidget {
  final String label;

  const SectionDivider({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Expanded(child: Divider()),
      xSpace(width: 5),
      subtext(label, fontSize: 12, color: GREY),
      xSpace(width: 5),
      const Expanded(child: Divider()),
    ]);
  }
}
