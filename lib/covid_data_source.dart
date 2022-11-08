import 'package:pertemuan6/basenetwork.dart';
class CovidDataSource {
  static CovidDataSource instance = CovidDataSource();
  Future<Map<String, dynamic>> loadCountries() {
    return BaseNetwork.get("countries");
  }
  
  Future<Map<String, dynamic>> loadCountries19() {
    return BaseNetwork.get("covid19");
  }
}