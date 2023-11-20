
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


class FText extends StatelessWidget {
  final String fText;
  final bool showDebbugBanner;

  const FText(
    this.fText, {
    super.key,
    required this.showDebbugBanner,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: kDebugMode && showDebbugBanner ? '[f]' : '',
      children: getSpanList(fText),
    ));
  }
}

var _rgex1times = r'(\*)';
var _rgex2times = r'^[^*]*\*[^*]*(\*)';

enum EnumFTextType {
  bold,
  normal,
}

@visibleForTesting
List<TextSpan> getSpanList(String text) {
  List<Map<EnumFTextType, String>> fList = [];
  String tmp = text;
  //TODO: Mudar || para &&
  while (tmp.contains('*') || tmp.contains('\\*')) {
    for (var pattern in [
      '*',
    ]) {
      var sliceFrom = tmp.indexOf(pattern);
      var sliceTo = tmp.indexOf(pattern, sliceFrom + 1);
      var normal = tmp.substring(0, sliceFrom);
      if (normal.isNotEmpty) {
        fList.add({getType(''): normal});
      }
      var bold = tmp.substring(sliceFrom, sliceTo + 1);
      if (bold.isNotEmpty) {
        tmp = tmp.substring(sliceTo + 1);
        fList.add({getType(pattern): bold.replaceAll(pattern, '')});
      }
    }
  }

  fList.add({EnumFTextType.normal: tmp});

  return fList.map<TextSpan>((f) {
    if (f.keys.first == EnumFTextType.normal) {
      return TextSpan(text: f.values.first);
    } else if (f.keys.first == EnumFTextType.bold) {
      return TextSpan(
        text: f.values.first,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
    } else {
      return const TextSpan(text: '');
    }
  }).toList();
}

EnumFTextType getType(String pattern) {
  switch (pattern) {
    case '*':
      return EnumFTextType.bold;
    default:
      return EnumFTextType.normal;
  }
}

class FSpan extends StatefulWidget {
  const FSpan({super.key});

  @override
  State<FSpan> createState() => _FSpanState();
}

class _FSpanState extends State<FSpan> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
