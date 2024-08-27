import 'package:intl/intl.dart';

import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/categories/virtual_card/strowallet_card/strowallet_transaction_controller.dart';
import '../../../../utils/basic_screen_import.dart';
import '../../../../widgets/appbar/appbar_widget.dart';
import '../../../../widgets/bottom_navbar/transaction_history_widget.dart';
import '../../../../widgets/others/expanded_transaction.dart';

class StrowalletTransactionHistoryScreen extends StatelessWidget {
  StrowalletTransactionHistoryScreen({super.key});
  final controller = Get.put(StrowalletTransactionController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(text: Strings.transactionHistory),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.strowalletCardTransactionsModel.data.cardTransactions;
    RxBool isExpansion = false.obs;
    return data.isNotEmpty
        ? RefreshIndicator(
            color: CustomColor.primaryLightColor,
            onRefresh: () async {
              controller.getCardTransactionHistory();
            },
            child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.marginSizeHorizontal * 0.9,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      isExpansion.value = !isExpansion.value;
                    },
                    child: Column(
                      children: [
                        TransactionWidget(
                         amount:        "${data[index].amount}  ${data[index].currency}",
                          title: data[index].narrative,
                          dateText:
                              DateFormat.M().format(data[index].createdAt),
                          transaction: data[index].status,
                          monthText:
                              DateFormat.MMMM().format(data[index].createdAt),
                        ),
                        Obx(
                          () => Visibility(
                            visible: isExpansion.value,
                            child: Container(
                                padding:
                                    EdgeInsets.all(Dimensions.paddingSize * .6),
                                decoration: BoxDecoration(
                                  color: CustomColor.primaryLightColor
                                      .withOpacity(0.9),
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.radius),
                                ),
                                child: Column(children: [
                                  ExpendedItemWidget(
                                    title: Strings.trxID,
                                    
                                    value: data[index].cardId,
                                  ),
                                  ExpendedItemWidget(
                                    title: Strings.cardType,
                                    value: data[index].type,
                                  ),
                                  ExpendedItemWidget(
                                    title: Strings.method,
                                    value: data[index].method,
                                  ),
                                  ExpendedItemWidget(
                                    title: Strings.amount,
                                    value:
                                        "${data[index].amount}  ${data[index].currency}",
                                  ),
                                  ExpendedItemWidget(
                                    title: Strings.reference,
                                    value: data[index].reference,
                                  ),
                                ])),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        : Center(
            child: TitleHeading1Widget(
              textAlign: TextAlign.center,
              text: Strings.noRecordFound,
              color: CustomColor.primaryLightColor,
            ),
          );
  }
}
