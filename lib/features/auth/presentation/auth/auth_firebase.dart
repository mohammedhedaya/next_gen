import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:next_gen/core/cache/cache_helper.dart';
import 'package:next_gen/core/service/service_locator.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) return;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      await auth.signInWithCredential(credential);

      // حفظ الـ userId في الكاش
      final user = auth.currentUser;
      await getIt<CacheHelper>().saveData(key: "userId", value: user?.uid);

      _showSnackBar(context, "Logged in with Google successfully");
      context.go("/bottomNavBar");
    } on FirebaseAuthException catch (e) {
      _showSnackBar(context, _getErrorMessage(e.code));
    } catch (e) {
      _showSnackBar(context, 'An error occurred. Please try again.');
    }
  }

  Future<void> signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      // حفظ الـ userId في الكاش
      final user = auth.currentUser;
      await getIt<CacheHelper>().saveData(key: "userId", value: user?.uid);

      _showSnackBar(context, "Logged in successfully");
      context.go("/bottomNavBar");
    } on FirebaseAuthException catch (e) {
      _showSnackBar(context, _getErrorMessage(e.code));
    } catch (e) {
      _showSnackBar(context, 'An error occurred. Please try again.');
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
}
