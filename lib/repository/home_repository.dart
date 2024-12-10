import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../model/datamodel.dart';
import '../res/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<DataModel> fetchProductsListApi() async {
    try {
      dynamic response =
      await _apiServices.getData(AppUrls.dataEndPoint);
      return response = DataModel.fromJson(response);
    } catch (e) {

      rethrow;

    }
  }
}