import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:task_manager_app/service/firebase_service.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _firebaseService = FirebaseService();

  Rxn<User> firebaseUser = Rxn<User>();

  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
    super.onInit();
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/home');
    }
  }

  register() async {
    isLoading.value = true;
    if (password.value != confirmPassword.value) {
      Get.snackbar("Error", "Password do not match");
      return;
    }
    try {
      await _firebaseService.register(email.value, password.value);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  login() async {
    isLoading.value = true;
    try {
      await _firebaseService.login(email.value, password.value);
    } catch (e) {
      Get.snackbar("error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await _firebaseService.logout();
  }
}
