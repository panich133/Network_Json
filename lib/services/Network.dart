import 'dart:convert';
import 'package:my_authen_jsonfeed/model/JsonTest.dart';
import 'package:my_authen_jsonfeed/model/Youtubes.dart';
import 'package:http/http.dart' as http;


class Network {

  //Json Array "[]"
  static Future<List<Youtube>> fetchJsonTest() async {

    final url ='https://jsonplaceholder.typicode.com/users';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //If the call to the server was successful, parse the JSON
      final List jsonResponse = json.decode(response.body);

     List<JsonTest> result = jsonResponse.map((index) => JsonTest.fromJson(index)).toList();

// for (var item in result ){
 //   print(item.username);
// }

//return youtubeList.youtubes;
    } else {
      throw Exception('Failed to load post');
    }
  }

   //Json Array "{}"
  static Future<List<Youtube>> fetchYoutube({final type = 'superhero'}) async {

    final url ='https://www.codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=${type}';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //If the call to the server was successful, parse the JSON
      final jsonResponse = json.decode(response.body);
      Youtubes youtubeList = Youtubes.fromJson(jsonResponse);

//         for (var item in youtubeList.youtubes){
//        print(item.title);
//     }

      return youtubeList.youtubes;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
