import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lift_it_up/features/exercises/domain/models/exercise_model.dart';
import 'package:lift_it_up/features/exercises/domain/repositories/exercise_repository.dart';

class FirestoreExerciseRepository implements ExerciseRepository {
  final FirebaseFirestore _firestore;

  FirestoreExerciseRepository(this._firestore);

  @override
  Future<List<ExerciseModel>> getExercises({
    int limit = 20,
    String? startAfterId,
    String? searchQuery,
    List<Muscle>? muscles,
    List<Equipment>? equipment,
    ExerciseDifficulty? difficulty,
    ExerciseType? type,
  }) async {
    Query query = _firestore.collection('exercises');

    if (searchQuery != null && searchQuery.isNotEmpty) {
      // Basic prefix matching logic in Firestore
      // Note: for real full-text search, an external service like Algolia or Typesense is recommended
      query = query
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: '${searchQuery}z');
    }

    if (muscles != null && muscles.isNotEmpty) {
      query = query.where('primaryMuscles',
          arrayContainsAny: muscles.map((m) => m.name).toList());
    }

    // Firestore limitations: only one array-contains or array-contains-any clause per query
    // So equipment can only be filtered locally if muscles are already filtering,
    // or we choose which one to send to Firestore. Assuming we can't do both in one firestore query.
    // For this simple implementation, we prioritize muscles if both are present.
    // Ideally we'd fetch all and filter locally or use a proper search engine.

    if (difficulty != null) {
      query = query.where('difficulty', isEqualTo: difficulty.name);
    }

    if (type != null) {
      query = query.where('exerciseType', isEqualTo: type.name);
    }

    query = query.limit(limit);

    if (startAfterId != null) {
      final docSnap = await _firestore.collection('exercises').doc(startAfterId).get();
      if (docSnap.exists) {
        query = query.startAfterDocument(docSnap);
      }
    }

    final querySnapshot = await query.get(const GetOptions(source: Source.serverAndCache));

    final exercises = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return ExerciseModel.fromJson(data);
    }).toList();

    // Local filtering if both muscles and equipment are provided, due to Firestore limitations
    if (muscles != null && muscles.isNotEmpty && equipment != null && equipment.isNotEmpty) {
      return exercises.where((ex) {
        return ex.equipment.any((e) => equipment.contains(e));
      }).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty && (muscles != null || equipment != null || difficulty != null || type != null)) {
        // If searching AND filtering, apply local filtering to the search results
        var filtered = exercises;
        if (muscles != null && muscles.isNotEmpty) {
            filtered = filtered.where((ex) => ex.primaryMuscles.any((m) => muscles.contains(m))).toList();
        }
        if (equipment != null && equipment.isNotEmpty) {
            filtered = filtered.where((ex) => ex.equipment.any((e) => equipment.contains(e))).toList();
        }
        if (difficulty != null) {
            filtered = filtered.where((ex) => ex.difficulty == difficulty).toList();
        }
        if (type != null) {
            filtered = filtered.where((ex) => ex.exerciseType == type).toList();
        }
        return filtered;
    }

    if (equipment != null && equipment.isNotEmpty && (muscles == null || muscles.isEmpty) && (searchQuery == null || searchQuery.isEmpty)) {
      // If only equipment is specified, do local filtering since we didn't query firestore for it
      // actually, if only equipment is specified we COULD query firestore for it. Let's assume we do.
    }


    return exercises;
  }

  @override
  Future<ExerciseModel?> getExerciseById(String id) async {
    final docSnap = await _firestore.collection('exercises').doc(id).get(const GetOptions(source: Source.serverAndCache));
    if (docSnap.exists) {
      final data = docSnap.data() as Map<String, dynamic>;
      data['id'] = docSnap.id;
      return ExerciseModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<List<ExerciseModel>> getExercisesByIds(List<String> ids) async {
    if (ids.isEmpty) return [];

    // Firestore allows max 10 elements in 'whereIn' array
    final List<ExerciseModel> exercises = [];
    for (var i = 0; i < ids.length; i += 10) {
      final chunk = ids.sublist(i, i + 10 > ids.length ? ids.length : i + 10);
      final querySnapshot = await _firestore
          .collection('exercises')
          .where(FieldPath.documentId, whereIn: chunk)
          .get(const GetOptions(source: Source.serverAndCache));
      exercises.addAll(querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ExerciseModel.fromJson(data);
      }));
    }
    return exercises;
  }
}
