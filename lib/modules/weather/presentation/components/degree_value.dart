import 'package:weeshr/utilities/constant/exported_packages.dart';

class DegreeValue extends StatelessWidget {
  const DegreeValue({
    Key? key,
    required this.degree,
    this.size,
    this.color,
  }) : super(key: key);

  final String degree;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        labeltext(
          degree,
          fontSize: size ?? 80,
          color: color ?? GREY,
          textAlign: TextAlign.center,
        ),
        labeltext(
          '°',
          fontSize: isObjectEmpty(size) ? 50 : 13,
          color: GREY_700,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
