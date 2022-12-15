import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mgramseva/model/Transaction/update_transaction.dart';
import 'package:mgramseva/utils/Constants/I18KeyConstants.dart';
import 'package:mgramseva/utils/error_logging.dart';

import '../repository/billing_service_repo.dart';
import '../repository/transaction_repo.dart';
import '../utils/Locilization/application_localizations.dart';
import '../utils/global_variables.dart';
import 'common_provider.dart';

class TransactionUpdateProvider with ChangeNotifier {
  var transactionController = StreamController.broadcast();
  var isPaymentSuccess = false;

  @override
  void dispose() {
    transactionController.close();
    super.dispose();
  }

  Future<void> updateTransaction(Map query, BuildContext context) async {
    UpdateTransactionDetails? transactionDetails;
    try {
      transactionDetails = await TransactionRepository()
          .updateTransaction({"transactionId": query['eg_pg_txnid']});
      if (transactionDetails != null &&
          transactionDetails.transaction != null) {
        print('not null');
        isPaymentSuccess = true;
        transactionController.add(transactionDetails);
        notifyListeners();
      }
      print('Transction: ');
      print(transactionDetails);
    } catch (e, s) {
      ErrorHandler().allExceptionsHandler(context, e, s);
      transactionController.addError('error');
    }
  }

  Future<void> downloadOrShareReceiptWithoutLogin(BuildContext context,
      UpdateTransactionDetails transactionObj, bool isWhatsAppShare) async {
    String input =
        '${ApplicationLocalizations.of(context).translate(i18.payment.WHATSAPP_TEXT_SHARE_RECEIPT)}';
    input = input.replaceAll(
        '{transaction}', transactionObj.transaction!.first.txnId.toString());
    try {
      var input = {
        "tenantId": transactionObj.transaction!.first.tenantId,
        "consumerCode": transactionObj.transaction!.first.consumerCode,
        "businessService": "WS",
      };

      await BillingServiceRepository()
          .fetchdBillPaymentsNoAuth(input)
          .then((res) async {
        var params = {
          "key": "ws-receipt",
          "tenantId": transactionObj.transaction!.first.tenantId
        };
        var body = {"Payments": res.payments};
        await BillingServiceRepository()
            .fetchdfilestordIDNoAuth(body, params)
            .then((value) async {
          var output = await BillingServiceRepository().fetchFiles(
              value!.filestoreIds!,
              transactionObj.transaction!.first.tenantId.toString());
          isWhatsAppShare
              ? CommonProvider().shareonwatsapp(output!.first,
                  transactionObj.transaction!.first.user!.mobileNumber, input)
              : CommonProvider().onTapOfAttachment(
                  output!.first, navigatorKey.currentContext);
        });
      });
    } catch (e, s) {
      ErrorHandler().allExceptionsHandler(navigatorKey.currentContext!, e, s);
      transactionController.addError('error');
    }
  }

  void callNotifier() {
    notifyListeners();
  }
}