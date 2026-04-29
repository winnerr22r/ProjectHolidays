import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';

/// Profile screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;
  final AuthService _authService = AuthService();
  bool _isUpdatingProfile = false;
  bool _isChangingPassword = false;

  @override
  void initState() {
    super.initState();
    _slideAnimationController = AnimationController(
      duration: AppDuration.verySlow,
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _slideAnimationController,
            curve: Curves.easeOut,
          ),
        );

    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? AppColors.primary,
      ),
    );
  }

  Future<void> _handleLogout() async {
    await _authService.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  Future<void> _showEditProfileDialog() async {
    final user = _authService.currentUser;
    if (user == null) {
      _showSnackBar(
        'Silakan login terlebih dahulu.',
        backgroundColor: Colors.red.shade600,
      );
      return;
    }

    final nameController = TextEditingController(text: user.displayName ?? '');
    final emailController = TextEditingController(text: user.email ?? '');

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Profile'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        hintText: 'Masukkan nama Anda',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Masukkan email Anda',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                _isUpdatingProfile
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : TextButton(
                        onPressed: () async {
                          final name = nameController.text.trim();
                          final email = emailController.text.trim();
                          if (name.isEmpty || email.isEmpty) {
                            _showSnackBar(
                              'Nama dan email wajib diisi.',
                              backgroundColor: Colors.red.shade600,
                            );
                            return;
                          }

                          setState(() => _isUpdatingProfile = true);
                          try {
                            await _authService.updateProfile(
                              displayName: name,
                              email: email,
                            );
                            if (mounted) {
                              _showSnackBar('Profil berhasil diperbarui.');
                              Navigator.pop(context);
                              this.setState(() {});
                            }
                          } catch (e) {
                            _showSnackBar(
                              e.toString(),
                              backgroundColor: Colors.red.shade600,
                            );
                          } finally {
                            if (mounted) {
                              setState(() => _isUpdatingProfile = false);
                            }
                          }
                        },
                        child: const Text('Simpan'),
                      ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showChangePasswordDialog() async {
    final user = _authService.currentUser;
    if (user == null || user.email == null) {
      _showSnackBar(
        'Silakan login terlebih dahulu.',
        backgroundColor: Colors.red.shade600,
      );
      return;
    }

    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Ubah Password'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password saat ini',
                        hintText: 'Masukkan password saat ini',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password baru',
                        hintText: 'Masukkan password baru',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Konfirmasi password baru',
                        hintText: 'Ulangi password baru',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                _isChangingPassword
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : TextButton(
                        onPressed: () async {
                          final currentPassword = currentPasswordController.text
                              .trim();
                          final newPassword = newPasswordController.text.trim();
                          final confirmPassword = confirmPasswordController.text
                              .trim();

                          if (currentPassword.isEmpty ||
                              newPassword.isEmpty ||
                              confirmPassword.isEmpty) {
                            _showSnackBar(
                              'Semua field wajib diisi.',
                              backgroundColor: Colors.red.shade600,
                            );
                            return;
                          }

                          if (newPassword != confirmPassword) {
                            _showSnackBar(
                              'Password baru tidak cocok.',
                              backgroundColor: Colors.red.shade600,
                            );
                            return;
                          }

                          setState(() => _isChangingPassword = true);
                          try {
                            await _authService.changePassword(
                              currentPassword: currentPassword,
                              newPassword: newPassword,
                            );
                            if (mounted) {
                              _showSnackBar('Password berhasil diubah.');
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            _showSnackBar(
                              e.toString(),
                              backgroundColor: Colors.red.shade600,
                            );
                          } finally {
                            if (mounted) {
                              setState(() => _isChangingPassword = false);
                            }
                          }
                        },
                        child: const Text('Ubah'),
                      ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final name = user?.displayName ?? 'Pengguna';
    final email = user?.email ?? 'Belum diatur';
    final avatarUrl = user?.photoURL;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile header section
                Column(
                  children: [
                    // Avatar
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: avatarUrl != null && avatarUrl.isNotEmpty
                            ? Image.network(
                                avatarUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _defaultAvatar();
                                },
                              )
                            : _defaultAvatar(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Name
                    Text(
                      name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Email
                    Text(
                      email,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                // Settings list
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _SettingItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        onTap: _showEditProfileDialog,
                      ),
                      const Divider(height: 1, color: AppColors.divider),
                      _SettingItem(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        onTap: _showChangePasswordDialog,
                      ),
                      const Divider(height: 1, color: AppColors.divider),
                      _SettingItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        onTap: () {
                          _showSnackBar('Notification settings coming soon');
                        },
                      ),
                      const Divider(height: 1, color: AppColors.divider),
                      _SettingItem(
                        icon: Icons.language,
                        title: 'Language',
                        onTap: () {
                          _showSnackBar('Language settings coming soon');
                        },
                      ),
                      const Divider(height: 1, color: AppColors.divider),
                      _SettingItem(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        onTap: () {
                          _showSnackBar('Help & Support coming soon');
                        },
                      ),
                      const Divider(height: 1, color: AppColors.divider),
                      _SettingItem(
                        icon: Icons.info_outline,
                        title: 'About App',
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'ProjectHolidays',
                            applicationVersion: '1.0.0',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: 'Logout',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _handleLogout();
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      color: AppColors.surfaceVariant,
      child: const Icon(Icons.person, color: AppColors.primary, size: 50),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
