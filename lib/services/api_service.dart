import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://devapiv3.dealsdray.com/api/v2/user';

  static Future<Map<String, dynamic>> addDeviceInfo(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/device/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> sendOTP(String mobileNumber, String deviceId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobileNumber': mobileNumber,
        'deviceId': deviceId,
      }),
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> verifyOTP(String otp, String deviceId, String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/otp/verification'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': otp,
        'deviceId': deviceId,
        'userId': userId,
      }),
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> registerWithEmail(String email, String password, int referralCode, String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/email/referral'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
        'referralCode': referralCode,
        'userId': userId,
      }),
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/home/withoutPrice'));
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
