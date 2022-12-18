import 'dart:convert';
import 'package:get/get.dart';
import 'package:intern_assignment_2/models/movie.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  var isLoading = false.obs;
  Movie? movie;

  // @override
  // void onInit() {
  //   fetchDate();
  //   super.onInit();
  // }

  fetchDate(String search) async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.tryParse('https://www.omdbapi.com/?apikey=566b193e&s=${search}')!);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body);
        movie = Movie.fromJson(jsonMap);
      } else {}
    } catch (e) {
      print('Error in fetching data $e');
    } finally {
      isLoading(false);
    }
  }
}
