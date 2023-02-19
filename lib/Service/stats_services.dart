import 'package:covid_tracker/Model/WorldStatsModel.dart';
import 'package:covid_tracker/Service/Utilities/app_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatsServices{
  Future<WorldStatsModel> getWorldStats() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatApi));
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      return WorldStatsModel.fromJson(data);
    }else{
      throw Exception('Unable to load Data');
    }
  }
  Future<List<dynamic>> getCountriesRecords() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
       data = json.decode(response.body);
      return data;
    }else{
      throw Exception('Unable to load Data');
    }
  }
  
}