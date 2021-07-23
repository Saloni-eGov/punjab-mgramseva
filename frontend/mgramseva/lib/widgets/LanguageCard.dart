import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mgramseva/model/localization/language.dart';
import 'package:mgramseva/providers/language.dart';

// import 'package:mgramseva/screeens/Consumer.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' hide Text;

class LanguageCard extends StatelessWidget {
  // final String text;
  // final String value;
  final Languages language;
  final List<Languages> languages;
  final int widthprect;
  final double cpadding;
  final double cmargin;

  final Function widgetFun;

  LanguageCard(this.language, this.languages, this.widthprect, this.cpadding,
      this.cmargin, this.widgetFun);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      var value = window.localStorage['SelectedLocal'];
      if (value == language.value) {
        this.language.isSelected = true;
      }
    }
    return Consumer<LanguageProvider>(
      builder: (_, languageProvider, child) => GestureDetector(
        onTap: () {
          languageProvider.onSelectionOfLanguage(
              language, languages);
        },
        child: Container(
            margin: new EdgeInsets.all(cmargin),
            width: MediaQuery.of(context).size.width / widthprect,
            padding: new EdgeInsets.all(cpadding),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: language.isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.white),
            child: Center(
                child: Text(
              '${language.label}',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: language.isSelected ? Colors.white : Colors.black),
            ))),
      ),
    );
  }
}
