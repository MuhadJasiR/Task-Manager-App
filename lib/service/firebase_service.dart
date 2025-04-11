import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_app/models/task_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future logout() async {
    await _auth.signOut();
  }

  CollectionReference getUserTaskCollection(String uid) {
    return _firestore.collection("users").doc(uid).collection("tasks");
  }

  Stream<List<TaskModel>> getTasks(String uid) {
    return getUserTaskCollection(uid).snapshots().map(
      (snapshot) =>
          snapshot.docs
              .map(
                (doc) => TaskModel.fromMap({
                  ...doc.data() as Map<String, dynamic>,
                  'id': doc.id,
                }),
              )
              .toList(),
    );
  }

  Future<void> addTask(String uid, TaskModel task) async {
    final taskDoc = getUserTaskCollection(uid).doc(task.id);
    await taskDoc.set(task.toJson());
  }

  Future<void> updateTask(String uid, TaskModel task) async {
    await getUserTaskCollection(uid).doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String uid, String taskId) async {
    await getUserTaskCollection(uid).doc(taskId).delete();
  }

  Future<void> toggleComplete(String id, bool isCompleted) async {
    String uid = _auth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(id)
        .update({'isCompleted': isCompleted});
  }
}
