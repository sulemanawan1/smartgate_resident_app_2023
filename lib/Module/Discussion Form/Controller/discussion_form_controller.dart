 import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/Discussion%20Form/Model/DiscussionFormModel.dart';

class DiscussionFormController  extends GetxController
{


  final TextEditingController msg = TextEditingController();

  List<DiscussionFormModel> v = [];


  
 List<DiscussionFormModel> getData(){
    
    v.add(DiscussionFormModel(sender: 1, chatroomid: 2, message: 'hi', lastmessage: '', updated_at: '', created_at: 'Suleman', reciever: 3, success: true));
    v.add(DiscussionFormModel(sender: 1, chatroomid: 2, message: 'hello', lastmessage: '', updated_at: '', created_at: 'Suleman', reciever: 3, success: true));
    v.add(DiscussionFormModel(sender: 2, chatroomid: 2, message: 'how r u mae thik hu bro tu suna tu kesa hai sub thik hai ghr mae ', lastmessage: '', updated_at: '', created_at: 'Ali', reciever: 3, success: true));
    v.add(DiscussionFormModel(sender: 2, chatroomid: 2, message: 'g janab ', lastmessage: '', updated_at: '', created_at: 'Iqra', reciever: 3, success: true));
    v.add(DiscussionFormModel(sender: 2, chatroomid: 2, message: 'sir g ', lastmessage: '', updated_at: '', created_at: 'Sana', reciever: 3, success: true));
    v.add(DiscussionFormModel(sender: 2, chatroomid: 2, message: 'kesy ho g', lastmessage: '', updated_at: '', created_at: 'Rimsha', reciever: 3, success: true));

    return  v;
  }




}