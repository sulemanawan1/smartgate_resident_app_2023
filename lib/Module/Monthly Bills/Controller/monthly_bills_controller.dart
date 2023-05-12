import 'dart:convert';
import 'package:get/get.dart';
import '../../../Constants/api_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import 'package:http/http.dart' as Http;
import '../../Login/Model/User.dart';
import '../Model/BillModel.dart';
class MonthlyBillsController extends GetxController

{

  var dueDate;
  var payAbleAmount;
  var latePayAbleAmount;
  var lateCharges;
  var data = Get.arguments;

  late final User userdata;
  late final Residents resident;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userdata = data[0];
    resident = data[1];
  }



  Future<BillModel> monthlyBillsApi(
      {required int userid, required String token}) async {
    print("${userid.toString()}");
    print(token);

    final response = await Http.get(
      Uri.parse(Api.monthlyBills + "/" + userid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());



    if (response.statusCode == 200) {
      return BillModel.fromJson(data);
    }

    return BillModel.fromJson(data);
  }


payBillApi(
      {required int id, required String token}) async {
    print("${id.toString()}");
    print(token);

    final response = await Http.get(
      Uri.parse(Api.payBill + "/" + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());



    if (response.statusCode == 200) {

      Get.snackbar('Success', data['message']);
      update();

    }

    else if (response.statusCode==500)
      {


        Get.snackbar('Warning', 'Something went Wrong');
        update();
      }

  }



toDateFormat({required dateString})

{
  DateTime date = DateTime.parse(dateString.toString());

  print(date);

  return date;

}



}