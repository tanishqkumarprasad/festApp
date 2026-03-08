import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'button.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  final String eventImage;
  final String campus;
  final String venue;
  final String coordinatorName;
  final String coordinatorPhone;
  final int participantsRequired;
  final String? registrationLink;
  final String? rulebookLink;
  final VoidCallback? onTap;
  final VoidCallback? onRegistrationTap;
  final VoidCallback? onRulebookTap;

  const EventCard({
    super.key,
    required this.eventName,
    required this.eventImage,
    required this.campus,
    required this.venue,
    required this.coordinatorName,
    required this.coordinatorPhone,
    required this.participantsRequired,
    this.registrationLink,
    this.rulebookLink,
    this.onTap,
    this.onRegistrationTap,
    this.onRulebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey[200],
                child: eventImage.isNotEmpty
                    ? Image.network(
                  eventImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 48,
                      ),
                    );
                  },
                )
                    : Center(
                  child: Icon(
                    Icons.image,
                    color: Colors.grey[400],
                    size: 48,
                  ),
                ),
              ),
            ),

            // Event Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Name
                  Text(
                    eventName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Campus
                  _buildInfoRow(
                    icon: Icons.school_outlined,
                    label: 'Campus:',
                    value: campus,
                  ),

                  // Venue
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Venue:',
                    value: venue,
                  ),
                  const SizedBox(height: 8),

                  // Participants Required
                  _buildInfoRow(
                    icon: Icons.group_outlined,
                    label: 'Participants:',
                    value: participantsRequired.toString(),
                  ),
                  const SizedBox(height: 8),

                  // Coordinator Details
                  _buildCoordinatorInfo(),
                  const SizedBox(height: 12),

                  // Action Buttons
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCoordinatorInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Coordinator',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            coordinatorName,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              // Handle phone call - can be extended with actual functionality
              _launchPhone(coordinatorPhone);
            },
            child: Text(
              coordinatorPhone,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        if (registrationLink != null && registrationLink!.isNotEmpty)
          Expanded(
            child: AppButton(
              text: 'Register',
              icon: Icons.app_registration,
              variant: AppButtonVariant.primary,
              size: AppButtonSize.medium,
              onPressed: onRegistrationTap,
            ),
          ),
        if (registrationLink != null &&
            registrationLink!.isNotEmpty &&
            rulebookLink != null &&
            rulebookLink!.isNotEmpty)
          const SizedBox(width: 8),
        if (rulebookLink != null && rulebookLink!.isNotEmpty)
          Expanded(
            child: AppButton(
              text: 'Rulebook',
              icon: Icons.description_outlined,
              variant: AppButtonVariant.secondary,
              size: AppButtonSize.medium,
              onPressed: onRulebookTap,
            ),
          ),
      ],
    );
  }

  void _launchPhone(String phoneNumber) {
    // Placeholder for phone launch functionality
    // In production, use url_launcher package:
    // final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    // launchUrl(launchUri);
    debugPrint('Phone: $phoneNumber'); // ✅ fixed
  }
}