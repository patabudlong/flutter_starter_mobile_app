import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/widgets/custom_app_bar.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/widgets/privacy_tile.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // Store initial values
  final Map<String, bool> _initialValues = {
    'profile': true,
    'location': false,
    'activity': true,
    'twoFactor': false,
  };

  // Current values
  bool _profileVisible = true;
  bool _locationEnabled = false;
  bool _activityVisible = true;
  bool _twoFactorEnabled = false;
  bool _isLoading = false;

  // Check if current values differ from initial values
  bool get _hasChanges {
    return _profileVisible != _initialValues['profile'] ||
           _locationEnabled != _initialValues['location'] ||
           _activityVisible != _initialValues['activity'] ||
           _twoFactorEnabled != _initialValues['twoFactor'];
  }

  void _onSettingChanged(String type, bool value) {
    setState(() {
      switch (type) {
        case 'profile':
          _profileVisible = value;
          break;
        case 'location':
          _locationEnabled = value;
          break;
        case 'activity':
          _activityVisible = value;
          break;
        case 'twoFactor':
          _twoFactorEnabled = value;
          break;
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ThemeUtils.dangerColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: ThemeUtils.dangerColor,
                  size: 30,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Discard Changes?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'You have unsaved changes. Are you sure you want to discard them?',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Keep Editing',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: ThemeUtils.dangerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Discard',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return result ?? false;
  }

  Future<void> _handleSave() async {
    setState(() => _isLoading = true);

    // TODO: Implement API call to save privacy settings

    setState(() {
      _isLoading = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Privacy settings saved successfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ThemeUtils.successColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        decoration: BoxDecoration(
          gradient: ThemeUtils.backgroundGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            title: 'Privacy Settings',
            showProfile: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                if (await _onWillPop()) {
                  if (mounted) Navigator.of(context).pop();
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: _hasChanges && !_isLoading ? _handleSave : null,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Save',
                        style: TextStyle(
                          color: _hasChanges 
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy & Security',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                PrivacyTile(
                  title: 'Profile Visibility',
                  subtitle: 'Make your profile visible to others',
                  icon: Icons.visibility_outlined,
                  value: _profileVisible,
                  onChanged: (value) => _onSettingChanged('profile', value),
                ),
                PrivacyTile(
                  title: 'Location Services',
                  subtitle: 'Allow app to access your location',
                  icon: Icons.location_on_outlined,
                  value: _locationEnabled,
                  onChanged: (value) => _onSettingChanged('location', value),
                ),
                PrivacyTile(
                  title: 'Activity Status',
                  subtitle: 'Show when you\'re active',
                  icon: Icons.access_time_outlined,
                  value: _activityVisible,
                  onChanged: (value) => _onSettingChanged('activity', value),
                ),
                PrivacyTile(
                  title: 'Two-Factor Authentication',
                  subtitle: 'Add an extra layer of security',
                  icon: Icons.security_outlined,
                  value: _twoFactorEnabled,
                  onChanged: (value) => _onSettingChanged('twoFactor', value),
                  showBadge: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 