import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/models/user.dart';

class ProfileDetails extends StatelessWidget {
  final User? user;
  final int maxNameLength = 20;

  const ProfileDetails({
    super.key,
    required this.user,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatValue(String? value) {
    if (value == null || value.isEmpty) return '';
    if (value.length <= maxNameLength) return value;
    return '${value.substring(0, maxNameLength)}...';
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              _formatValue(value),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow('First Name', user?.firstName),
          _buildDetailRow('Middle Name', user?.middleName),
          _buildDetailRow('Last Name', user?.lastName),
          _buildDetailRow('Extension', user?.extensionName),
          _buildDetailRow('Username', user?.username),
          _buildDetailRow('Member Since', _formatDate(user?.createdAt)),
          _buildDetailRow('Last Updated', _formatDate(user?.updatedAt)),
        ],
      ),
    );
  }
} 