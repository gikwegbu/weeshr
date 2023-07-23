import 'package:weeshr/utilities/constant/exported_packages.dart';

Column weatherItem({
    required String title,
    required String content,
  }) {
    return Column(
      children: [
        subtext(
          title,
          color: GREY_500,
        ),
        labeltext(content),
      ],
    );
  }