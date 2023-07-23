import 'package:weeshr/utilities/constant/exported_packages.dart';

class Wrapper extends StatelessWidget {
  final Widget body;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool isCancel;
  final bool closeOnTap;
  final bool safeTop;
  final bool safeBottom;
  final bool hasBar;
  final double? leadingWidth;
  final GestureTapCallback? onTap;

  const Wrapper({
    Key? key,
    this.actions,
    required this.body,
    this.title,
    this.safeBottom = true,
    this.safeTop = true,
    this.hasBar = false,
    this.leading,
    this.floatingActionButton,
    this.backgroundColor,
    this.padding,
    this.leadingWidth,
    this.onTap,
    this.isCancel = true,
    this.closeOnTap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xFFF7F9FA),
      appBar: AppBar(
        backgroundColor: backgroundColor ?? const Color(0xFFF7F9FA),
        elevation: 0,
        title: title,
        centerTitle: true,
        toolbarHeight: 60,
        leading: !isObjectEmpty(leading)
            ? leading
            : Visibility(
                visible: !isCancel,
                child: GestureDetector(
                  onTap: onTap ?? () => navigateBack(context),
                  child: Padding(
                    padding: hasBar
                        ? const EdgeInsets.only(top: 30.0)
                        : const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      ImageUtils.backSvg,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
        leadingWidth: leadingWidth,
        actions: actions ??
            (!closeOnTap
                ? []
                : [
                    GestureDetector(
                      onTap: onTap ?? () => navigateBack(context),
                      child: Padding(
                        padding: hasBar
                            ? const EdgeInsets.only(top: 30.0)
                            : const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          ImageUtils.cancelSvg,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    )
                  ]),
      ),
      body: SafeArea(
        top: safeTop,
        bottom: safeBottom,
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          padding: padding ?? screenPadding,
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

class SignupWrapper extends StatelessWidget {
  const SignupWrapper({
    Key? key,
    required this.body,
    required this.footer,
  }) : super(key: key);
  final Widget body;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body,
        Align(
          alignment: Alignment.bottomCenter,
          child: footer,
        ),
      ],
    );
  }
}

class BottomSheetWrapper extends StatelessWidget {
  final Widget child;
  final bool closeOnTap;

  const BottomSheetWrapper({
    Key? key,
    required this.child,
    this.closeOnTap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: screenWidth(context),
          constraints: BoxConstraints(
            maxHeight: screenHeight(context) * .85,
          ),
          margin: EdgeInsets.only(top: closeOnTap ? 40 : 20),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: closeOnTap ? 36 : 16.0,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: child,
            ),
          ),
        ),
        if (closeOnTap)
          Positioned(
            right: 0,
            top: 16,
            child: MaterialButton(
              onPressed: () => navigateBack(context),
              child: SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset("ImageUtils.cancelSvg"),
              ),
            ),
          ),
      ],
    );
  }
}
