import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi{
    final String _url = 'https://www.dynamyk.biz/';
  // final String _url = 'http://127.0.0.1:3333/';
   //final String _url = 'http://10.0.2.2:3333/';
    

    postData(data, apiUrl) async {
        var fullUrl = _url + apiUrl;
       // print(await _setHeaders());
        return await http.post(
            fullUrl, 
            body: jsonEncode(data), 
            headers: await _setHeaders()
        );
        
    }
    editData(data, apiUrl) async {
        var fullUrl = _url + apiUrl;
       // print(await _setHeaders());
        return await http.put(
            fullUrl, 
            body: jsonEncode(data), 
            headers: await _setHeaders()
        );
        
    }
   
    getData(apiUrl) async {
       var fullUrl = _url + apiUrl; 
     //  print(fullUrl);
       return await http.get(
         fullUrl, 
         headers:  await _setHeaders()
       );
    }

    _setHeaders() async => {
       "Authorization" : 'Bearer ' + await _getToken(),
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
    };

    

    _getToken() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.getString('token');
        print(localStorage.getString('id'));
        return '$token';
    }
}
