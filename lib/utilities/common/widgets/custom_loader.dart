import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:weeshr/utilities/constant/exported_packages.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
    this.color = PRIMARY,
  }) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // const spinKit = SpinKitDualRing(
    final spinKit = SpinKitSpinningLines(
      // const spinKit = SpinKitFadingCircle(
      color: color!,
      size: 25.0,
      // lineWidth: 3,
      duration:const Duration(milliseconds: 400),
    );
    return Center(
      child: spinKit,
    );
  }
}

class DataLoader extends StatelessWidget {
 const DataLoader({
    Key? key,
    this.height,
    required this.image,
  }) : super(key: key);
 final  double? height;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(image, height: height ?? 60),
    );
  }
}

class ImageLoader extends StatelessWidget {
  final double size;

  const ImageLoader({Key? key, this.size = 30.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spinKit = SpinKitRipple(
      color: PRIMARY,
      size: size,
    );

    return Center(
      child: spinKit,
    );
  }
}

class EmptyState extends StatelessWidget {
 const EmptyState({
    Key? key,
    this.image,
    required this.description,
    this.height,
  }) : super(key: key);
 final String? image;
  final double? height;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          DataLoader(
            image: image ?? ImageUtils.emptyStateLoader,
            height: height ?? screenHeight(context) * 0.15,
          ),
          ySpace(),
          Center(
            child: labeltext(
              description,
              color: GREY_500,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
