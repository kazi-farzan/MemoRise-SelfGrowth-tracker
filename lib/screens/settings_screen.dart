import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildPersonalizationSection(context),
          Divider(),
          _buildAccountSettingsSection(context),
          Divider(),
          _buildThemeSettingsSection(context),
          Divider(),
          _buildOtherSettingsSection(context),
        ],
      ),
    );
  }

  Widget _buildPersonalizationSection(BuildContext context) {
    return ExpansionTile(
      title: Text('Personalization Options'),
      children: [
        ListTile(
          title: Text('Custom Moods'),
          subtitle: Text('Add or remove moods'),
          onTap: () {
            // Navigate to custom moods screen or implement action
            // Example: Navigator.pushNamed(context, '/custom_moods');
          },
        ),
        ListTile(
          title: Text('Reminders'),
          subtitle: Text('Set reminders for mood entries'),
          onTap: () {
            // Navigate to reminders settings or implement action
            // Example: Navigator.pushNamed(context, '/reminders');
          },
        ),
      ],
    );
  }

  Widget _buildAccountSettingsSection(BuildContext context) {
    return ExpansionTile(
      title: Text('Account Settings'),
      children: [
        ListTile(
          title: Text('Backup and Sync Options'),
          subtitle: Text('Manage data backup and synchronization'),
          onTap: () {
            // Navigate to backup and sync settings or implement action
            // Example: Navigator.pushNamed(context, '/backup_sync');
          },
        ),
        ListTile(
          title: Text('Privacy and Security'),
          subtitle: Text('Manage privacy preferences'),
          onTap: () {
            // Navigate to privacy settings or implement action
            // Example: Navigator.pushNamed(context, '/privacy');
          },
        ),
      ],
    );
  }

  Widget _buildThemeSettingsSection(BuildContext context) {
    return ExpansionTile(
      title: Text('Theme and Display Preferences'),
      children: [
        ListTile(
          title: Text('Theme Selection'),
          subtitle: Text('Choose app color theme'),
          onTap: () {
            // Navigate to theme selection screen or implement action
            // Example: Navigator.pushNamed(context, '/theme_selection');
          },
        ),
        ListTile(
          title: Text('Display Settings'),
          subtitle: Text('Adjust font sizes and layout'),
          onTap: () {
            // Navigate to display settings or implement action
            // Example: Navigator.pushNamed(context, '/display_settings');
          },
        ),
      ],
    );
  }

  Widget _buildOtherSettingsSection(BuildContext context) {
    return ExpansionTile(
      title: Text('Other Customization Features'),
      children: [
        ListTile(
          title: Text('Notification Settings'),
          subtitle: Text('Manage notification preferences'),
          onTap: () {
            // Navigate to notification settings or implement action
            // Example: Navigator.pushNamed(context, '/notification_settings');
          },
        ),
        ListTile(
          title: Text('Language and Region Settings'),
          subtitle: Text('Adjust language and regional preferences'),
          onTap: () {
            // Navigate to language settings or implement action
            // Example: Navigator.pushNamed(context, '/language_settings');
          },
        ),
      ],
    );
  }
}
