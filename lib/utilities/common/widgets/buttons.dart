import 'package:weeshr/utilities/common/widgets/custom_loader.dart';
import 'package:weeshr/utilities/constant/exported_packages.dart';

class SubmitBtn extends StatelessWidget {
  final Widget title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? image;
  final VoidCallback? onPressed;
  final bool loading;
  final bool isEnabled;
  final String? loadingTxt;
  final Color? color;
  final double? height;

  const SubmitBtn({
    Key? key,
    required this.onPressed,
    required this.title,
    this.leftIcon,
    this.rightIcon,
    this.color,
    this.image,
    this.loading = false,
    this.loadingTxt,
    this.isEnabled = true,
    this.height = 62,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: loading
          ? ElevatedButton.icon(
              icon: const Loader(),
              onPressed: null,
              label: btnTxt(loadingTxt ?? ''),
              style: ElevatedButton.styleFrom(
                onSurface: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            )
          : Stack(
              children: [
                ElevatedButton(
                  onPressed: isEnabled ? onPressed : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!isObjectEmpty(leftIcon))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: leftIcon,
                        ),
                      title,
                      if (!isObjectEmpty(rightIcon))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: rightIcon,
                        ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: color ?? PRIMARY,
                    padding: const EdgeInsets.all(20.0),
                    shadowColor: Colors.transparent,
                    side: const BorderSide(
                      color: GREY_300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Text btnTxt(String title, [Color? color, double? fontSize]) {
  return subtext(
    title,
    color: color ?? Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: fontSize ?? 16,
  );
}
