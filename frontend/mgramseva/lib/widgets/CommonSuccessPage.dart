import 'package:flutter/material.dart';
import 'package:mgramseva/model/success_handler.dart';
import 'package:mgramseva/utils/Constants/I18KeyConstants.dart';
import 'package:mgramseva/utils/Locilization/application_localizations.dart';
import 'package:mgramseva/utils/common_methods.dart';
import 'package:mgramseva/widgets/BaseAppBar.dart';
import 'package:mgramseva/widgets/BottonButtonBar.dart';
import 'package:mgramseva/widgets/HomeBack.dart';
import 'package:mgramseva/widgets/SuccessPage.dart';

class CommonSuccess extends StatelessWidget {
  final SuccessHandler successHandler;
  final VoidCallback? callBack;
  final bool? backButton;

  CommonSuccess(this.successHandler, {this.callBack, this.backButton});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        CommonMethods.home();
        return false;
      },
      child: Scaffold(
          appBar: BaseAppBar(
            Text(i18.common.MGRAM_SEVA),
            AppBar(),
            <Widget>[Icon(Icons.more_vert)],
          ),
          body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                backButton == true ? HomeBack(callback: CommonMethods.home) : Text(''),
                Card(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SuccessPage(successHandler.header, subText: successHandler.subHeader),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, bottom: 20, top: 20),
                          child: Text(
                              ApplicationLocalizations.of(context)
                                  .translate(successHandler.subtitle),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                        )),
                    Visibility(
                      visible: successHandler.downloadLink == null && successHandler.whatsAppShare == null && successHandler.downloadLinkLabel == null,
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: successHandler.downloadLink != null,
                          child: TextButton.icon(onPressed: (){},
                          icon: Icon(Icons.download_sharp),
                            label: Text( ApplicationLocalizations.of(context)
                                .translate(successHandler.downloadLinkLabel != null ? successHandler.downloadLinkLabel! : '' ), style: TextStyle(fontSize: 19)),
                          ),
                        ),
                        Visibility(
                          visible: successHandler.whatsAppShare != null,
                          child: TextButton.icon(
                            onPressed: (){},
                            icon:  (Image.asset('assets/png/whats_app.png')),
                            label: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              child: Text(
                                  ApplicationLocalizations.of(context)
                                      .translate(i18.common.SHARE_BILL)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    BottomButtonBar(
                      successHandler.backButtonText,
                      callBack != null ? callBack : CommonMethods.home,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ))
              ]))),
    );
  }
}
