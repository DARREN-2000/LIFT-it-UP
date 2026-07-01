import 'package:cloud_firestore/cloud_firestore.dart';

class UserExerciseDataRepository {
  final FirebaseFirestore _firestore;

  UserExerciseDataRepository(this._firestore);

  Future<List<String>> getFavoriteExerciseIds(String userId) async {
    final docSnap = await _firestore
        .collection('users')
        .doc(userId)
        .collection('exerciseData')
        .doc('favorites')
        .get(const GetOptions(source: Source.serverAndCache));

    if (docSnap.exists) {
      final data = docSnap.data();
      if (data != null && data.containsKey('exerciseIds')) {
        return List<String>.from(data['exerciseIds']);
      }
    }
    return [];
  }

  Future<void> toggleFavoriteExercise(String userId, String exerciseId, bool isFavorite) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('exerciseData')
        .doc('favorites');

    if (isFavorite) {
      await docRef.set({
        'exerciseIds': FieldValue.arrayUnion([exerciseId])
      }, SetOptions(merge: true));
    } else {
      await docRef.set({
        'exerciseIds': FieldValue.arrayRemove([exerciseId])
      }, SetOptions(merge: true));
    }
  }

  Future<List<String>> getRecentlyViewedExerciseIds(String userId) async {
    final docSnap = await _firestore
        .collection('users')
        .doc(userId)
        .collection('exerciseData')
        .doc('recentlyViewed')
        .get(const GetOptions(source: Source.serverAndCache));

    if (docSnap.exists) {
      final data = docSnap.data();
      if (data != null && data.containsKey('exerciseIds')) {
        return List<String>.from(data['exerciseIds']);
      }
    }
    return [];
  }

  Future<void> addRecentlyViewedExercise(String userId, String exerciseId) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('exerciseData')
        .doc('recentlyViewed');

    // Remove the item if it already exists, then add to the beginning
    // Firestore doesn't have a built-in 'add to beginning of array', so we'll maintain a list and update
    final docSnap = await docRef.get();
    List<String> currentList = [];
    if (docSnap.exists) {
        final data = docSnap.data();
        if (data != null && data.containsKey('exerciseIds')) {
            currentList = List<String>.from(data['exerciseIds']);
        }
    }

    currentList.remove(exerciseId);
    currentList.insert(0, exerciseId);

    // Keep only the last 20
    if (currentList.length > 20) {
        currentList = currentList.sublist(0, 20);
    }

    await docRef.set({
      'exerciseIds': currentList
    }, SetOptions(merge: true));
  }
}
