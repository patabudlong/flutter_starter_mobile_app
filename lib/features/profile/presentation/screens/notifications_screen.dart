import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/utils/theme_utils.dart';
import 'package:flutter_starter_mobile_app/widgets/custom_app_bar.dart';
import 'package:flutter_starter_mobile_app/features/profile/presentation/widgets/notification_tile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushEnabled = true;
  bool _emailEnabled = true;
  bool _smsEnabled = false;
  bool _hasChanges = false;
  bool _isLoading = false;

  void _onSettingChanged(String type, bool value) {
    setState(() {
      switch (type) {
        case 'push':
          _pushEnabled = value;
          break;
        case 'email':
          _emailEnabled = value;
          break;
        case 'sms':
          _smsEnabled = value;
          break;
      }
      _hasChanges = true;
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

    // TODO: Implement API call to save notification settings

    setState(() {
      _isLoading = false;
      _hasChanges = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Notification settings saved successfully',
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
            title: 'Notifications',
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
                  'Notification Preferences',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                NotificationTile(
                  title: 'Push Notifications',
                  subtitle: 'Receive push notifications on your device',
                  icon: Icons.notifications_outlined,
                  value: _pushEnabled,
                  onChanged: (value) => _onSettingChanged('push', value),
                ),
                NotificationTile(
                  title: 'Email Notifications',
                  subtitle: 'Receive notifications via email',
                  icon: Icons.email_outlined,
                  value: _emailEnabled,
                  onChanged: (value) => _onSettingChanged('email', value),
                ),
                NotificationTile(
                  title: 'SMS Notifications',
                  subtitle: 'Receive notifications via SMS',
                  icon: Icons.message_outlined,
                  value: _smsEnabled,
                  onChanged: (value) => _onSettingChanged('sms', value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 