import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:movie_application/model/bookmark.dart';

class DatabaseService {
  final CollectionReference bookmarkCollection =
      FirebaseFirestore.instance.collection('bookmarks');

  Future createCollectionForUser(
      String uid, dynamic animeId, dynamic animeTitle, dynamic animeImg) async {
    return await bookmarkCollection
        .doc(uid)
        .collection('userBookmark')
        .doc(animeId)
        .set({
      'animeId': animeId,
      'animeTitle': animeTitle,
      'animeImg': animeImg,
    });
  }

  Future deleteBookmark(String uid, dynamic animeId) async {
    return await bookmarkCollection
        .doc(uid)
        .collection('userBookmark')
        .doc(animeId)
        .delete();
  }

  Future<bool> getBookmarkStatus(String uid, dynamic animeId) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('bookmarks')
        .doc(uid)
        .collection('userBookmark')
        .doc(animeId);
    DocumentSnapshot snapshot = await documentReference.get();
    return snapshot.exists ? true : false;
  }

  Future<List<Bookmark>?> getAllUserBookmarks(String uid) async {
    try {
      final CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('bookmarks')
          .doc(uid)
          .collection('userBookmark');
      QuerySnapshot querySnapshot = await collectionReference.get();
      List<Bookmark> listBookmark = [];
      for (var doc in querySnapshot.docs) {
        listBookmark.add(Bookmark.fromJson(doc.data() as Map<String, dynamic>));
      }
      return listBookmark;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
