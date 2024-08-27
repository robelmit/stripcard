import 'package:carousel_slider/carousel_slider.dart';
import '../../backend/local_storage.dart';
import '../../backend/model/dashboard/dashboard_model.dart';
import '../../backend/services/api_services.dart';
import '../../utils/basic_screen_import.dart';

class DashBoardController extends GetxController {
  final CarouselController carouselController = CarouselController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  RxInt current = 0.obs;
  RxString activeVirtualSystem = ''.obs;
  RxDouble percentCharge = 0.0.obs;
  RxDouble fixedCharge = 0.0.obs;
  RxDouble rate = 0.0.obs;
  RxDouble limitMin = 0.0.obs;
  RxDouble limitMax = 0.0.obs;
  @override
  void onInit() {
    getDashboardData();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late DashBoardModel _dashBoardModel;
  DashBoardModel get dashBoardModel => _dashBoardModel;

  Future<DashBoardModel> getDashboardData() async {
    _isLoading.value = true;
    update();

    await ApiServices.dashboardApi().then((value) {
      _dashBoardModel = value!;
      final data = _dashBoardModel.data.user;
      firstNameController.text = data.firstname;
      lastNameController.text = data.lastname;
      emailController.text = data.email;
      limitMin.value = _dashBoardModel.data.cardReloadCharge.minLimit;
      limitMax.value = _dashBoardModel.data.cardReloadCharge.maxLimit;
      percentCharge.value = _dashBoardModel.data.cardReloadCharge.percentCharge;
      fixedCharge.value = _dashBoardModel.data.cardReloadCharge.fixedCharge;
      rate.value = 1.0;
      activeVirtualSystem.value = _dashBoardModel.data.activeVirtualSystem;
      debugPrint("""🌟🌟🌟 
      
                     ${activeVirtualSystem.value} 
                                
                                 🌟🌟🌟""");
      LocalStorage.saveBaseCurrency(currency: _dashBoardModel.data.baseCurr);
      LocalStorage.saveKycStatus(status: _dashBoardModel.data.user.kycVerified);
      update();

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _dashBoardModel;
  }
}
