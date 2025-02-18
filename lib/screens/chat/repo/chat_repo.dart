import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/api.dart';
import 'package:zineapp2023/models/message.dart';

class ChatRepo {
  // final SharedPreferences prefs;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<MessageModel> chats = [];
  // ChatProvider();

  // String? getPref(String key) {
  //   return prefs.getString(key);
  // }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return _firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Future<String?> getRoomId(String groupName) {
    return _firebaseFirestore
        .collection('rooms')
        .where('name', isEqualTo: groupName)
        .limit(1) // Assuming there is only one group with the given name
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
    });
  }

  dynamic getChatStream(String groupName) async {
    return _firebaseFirestore
        .collection('rooms')
        .where('name', isEqualTo: groupName)
        .limit(1) // Assuming there is only one group with the given name
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final groupChatId = querySnapshot.docs.first.id;
        return _firebaseFirestore
            .collection('rooms')
            .doc(groupChatId)
            .collection('messages')
            .snapshots();
      } else {
        throw Exception('No matching documents');
      }
    });
  }

  dynamic getLastChat(String roomName) async {
    String? groupChatId = await getRoomId(roomName);
    // print(groupChatId.toString());
    var data = await _firebaseFirestore
        .collection('rooms')
        .doc(groupChatId.toString())
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .limit(1)
        .get();
    var lastChat;
    // print(data.docs);
    if (data.docs != null && data.docs.length > 0) {
      return lastChat = MessageModel.store(data.docs[0]);
    }
    return null;
  }

  Query<Map<String, dynamic>> getRooms(String groupChatId) {
    return _firebaseFirestore
        .collection('rooms')
        .where('name', isEqualTo: groupChatId);
    // .get();
    // chats = List.from(data.docs.map((doc) => MessageModel.store(doc)));
    // .limit(limit)
  }

  void sendMessage(
    String from,
    String roomName,
    String message,
  ) async {
    String? groupId = await getRoomId(roomName);
    groupId = groupId.toString();
    DocumentReference documentReference = _firebaseFirestore
        .collection('rooms')
        .doc(groupId)
        .collection('messages')
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    MessageModel messageChat = MessageModel(
        from: from,
        group: groupId,
        message: message,
        timeStamp: Timestamp.now());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
    sendFCMMessage(roomName, from, message);
  }
}
