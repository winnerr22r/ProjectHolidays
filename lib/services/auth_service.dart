import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Register with email and password
  Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(displayName);
      await userCredential.user?.reload();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Login with email and password
  Future<UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Update display name and email
  Future<void> updateProfile({String? displayName, String? email}) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw 'User tidak ditemukan. Silakan login kembali.';
    }

    try {
      if (displayName != null && displayName.trim().isNotEmpty) {
        await currentUser.updateDisplayName(displayName.trim());
      }

      if (email != null &&
          email.trim().isNotEmpty &&
          email.trim() != currentUser.email) {
        await currentUser.verifyBeforeUpdateEmail(email.trim());
      }

      await currentUser.reload();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Change password after re-authentication
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null || currentUser.email == null) {
      throw 'User tidak ditemukan. Silakan login kembali.';
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password: currentPassword,
      );
      await currentUser.reauthenticateWithCredential(credential);
      await currentUser.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Convert an authentication error into a readable message.
  String getAuthErrorMessage(Object error) {
    if (error is FirebaseAuthException) {
      return _handleAuthException(error);
    }
    if (error is String) {
      return error;
    }
    return 'Terjadi kesalahan: ${error.toString()}';
  }

  /// Handle Firebase Authentication exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password terlalu lemah. Gunakan minimal 6 karakter dengan kombinasi huruf dan angka.';
      case 'email-already-in-use':
        return 'Email sudah terdaftar. Gunakan email lain atau coba login.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'user-disabled':
        return 'Akun pengguna telah dinonaktifkan.';
      case 'user-not-found':
        return 'Email tidak terdaftar. Silakan daftar terlebih dahulu.';
      case 'wrong-password':
        return 'Password salah. Silakan coba lagi.';
      case 'invalid-credential':
        return 'Email atau password salah.';
      case 'requires-recent-login':
        return 'Aksi ini memerlukan login ulang. Silakan logout dan login kembali.';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi nanti.';
      case 'operation-not-allowed':
        return 'Email/password sign-in belum diaktifkan di Firebase Console.';
      case 'email-already-exists':
        return 'Email sudah terdaftar. Silakan gunakan email lain atau login.';
      case 'invalid-api-key':
        return 'Konfigurasi Firebase tidak valid. Periksa API key di firebase_options.dart.';
      default:
        final message = e.message ?? 'Terjadi kesalahan tidak dikenal.';
        return 'Terjadi kesalahan (${e.code}): $message';
    }
  }
}
