import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper
{
  static ApiHelper apiHelper = ApiHelper._();
  ApiHelper._();
  Future<void> postApi(String? fmcToken,String title,String body)
  async {
    String link = "https://fcm.googleapis.com/fcm/send";
    Uri uri = Uri.parse(link);
    final msg = jsonEncode({
      "to":"$fmcToken",
      "notification": {
        "title":"$title",
        "body":"$body",
      }
    });
    var json = await http.post(uri,body: msg,headers: {
      "Content-Type":"application/json",
      "Authorization":"key=AAAAh3snsek:APA91bHowXK8VfEacjQPuwXkH-LhMuAa9uY_VUYpk9VgziWpibB7pdshUWWWo4ME9LNr5NTmojSJmJTbzgccwp052C-y4_Y59mXsbamD8bDkCPEH5n8OMfKeDR2BHNPeATx8iLYkmdN8",
    });
  }
}