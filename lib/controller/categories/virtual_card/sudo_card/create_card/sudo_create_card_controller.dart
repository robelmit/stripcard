import '../../../../../../backend/services/api_services.dart';
import '../../../../../../language/strings.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/basic_widget_import.dart';
import '../../../../../../widgets/others/congratulation_widget.dart';
import '../../../../../backend/model/common/common_success_model.dart';
import '../../../../../backend/model/virtual_card/sudo_models/sudo_charges_model.dart';

class SudoCreateCardController extends GetxController {
  final amountTextController = TextEditingController();
  List<String> totalAmount = [];

  @override
  void dispose() {
    amountTextController.dispose();

    super.dispose();
  }

  @override
  void onInit() {
    _getCardChargesData();
    super.onInit();
  }

  goToCreateNewCardPreviewScreen() {
    Get.toNamed(Routes.sudoCreateNewCardPreviewScreen);
  }

  RxString selectItem = ''.obs;
  List<String> keyboardItemList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '<'
  ];
  List currencyList = ['USD', 'BDT'];
  List gatewayList = ['Paypal', 'Stripe'];

  inputItem(int index) {
    return InkWell(
      // overlayColor: MaterialStateProperty.all(Colors.transparent),
      onLongPress: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.clear();
            amountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        }
      },
      onTap: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.removeLast();
            amountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        } else {
          if (totalAmount.contains('.') && index == 9) {
            return;
          } else {
            totalAmount.add(keyboardItemList[index]);
            amountTextController.text = totalAmount.join('');
            debugPrint(totalAmount.join(''));
          }
        }
      },
      child: Center(
        child: CustomTitleHeadingWidget(
          text: keyboardItemList[index],
          style: Get.isDarkMode
              ? CustomStyle.lightHeading2TextStyle.copyWith(
                  fontSize: Dimensions.headingTextSize3 * 2,
                )
              : CustomStyle.darkHeading2TextStyle.copyWith(
                  color: CustomColor.primaryTextColor,
                  fontSize: Dimensions.headingTextSize3 * 2,
                ),
        ),
      ),
    );
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // card charges info
  late SudoCardChargesModel _cardChargesModel;
  SudoCardChargesModel get cardChargesModel => _cardChargesModel;

  Future<SudoCardChargesModel> _getCardChargesData() async {
    _isLoading.value = true;
    update();

    await ApiServices.sudoCardChargesApi().then((value) {
      _cardChargesModel = value!;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
      update();
    });

    _isLoading.value = false;
    update();
    return _cardChargesModel;
  }

  // create card  process
  late CommonSuccessModel _createCardModel;
  CommonSuccessModel get createCardModel => _createCardModel;

  Future<CommonSuccessModel> createCardProcess(context) async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'card_amount': amountTextController.text,
    };
    await ApiServices.sudoCreateCardApi(body: inputBody).then((value) {
      _createCardModel = value!;
      update();

      StatusScreen.show(
        context: context,
        subTitle: Strings.yourCardSuccess.tr,
        onPressed: () {
          Get.offAllNamed(Routes.bottomNavBarScreen);
        },
      );
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _createCardModel;
  }

  // getter
  get getCardChargesData => _getCardChargesData();
}
