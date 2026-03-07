
import 'package:flutter/material.dart';
import 'package:fest_app/data/models/notice_model.dart';
import 'package:intl/intl.dart'; // import for clean date formatting
import 'package:url_launcher/url_launcher.dart'; // import for button functionality

class NoticeDetailScreen extends StatelessWidget {
  final NoticeModel notice;

  const NoticeDetailScreen({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    // A. Clean up date formatting
    final String postDate = notice.createdAt != null
        ? DateFormat('yyyy-MM-dd').format(notice.createdAt!) // YYYY-MM-DD format
        : "Recently";

    final String eventDateStr = notice.eventDate != null
        ? DateFormat('yyyy-MM-dd').format(notice.eventDate!) // YYYY-MM-DD format
        : "TBA";

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: CustomScrollView(
        slivers: [
          // 1. Professional Parallax Image Header
          SliverAppBar(
            expandedHeight: notice.imageUrl.isNotEmpty ? 350.0 : 120.0,
            pinned: true,
            backgroundColor: const Color(0xFF0F172A),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: notice.imageUrl.isNotEmpty
                  ? Image.network(
                notice.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF1E293B),
                  child: const Center(child: Icon(Icons.image_not_supported, color: Colors.white54, size: 50)),
                ),
              )
                  : Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // 2. The Content Body
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF020617),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // B. Title
                    Text(
                      notice.eventName.isEmpty ? "Notice Event" : notice.eventName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- OVERFLOW FIX: Date Pills in Horizontally Scrollable Row ---
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      // Add a little padding to the left of the internal Row for cleaner look within the parent Container's horizontal padding
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Row(
                          children: [
                            _buildInfoPill(Icons.event, "Event: $eventDateStr", Colors.purpleAccent),
                            const SizedBox(width: 12),
                            _buildInfoPill(Icons.access_time, "Posted: $postDate", Colors.white54),
                          ],
                        ),
                      ),
                    ),
                    // -----------------------------------------------------------------

                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFF1E293B), thickness: 1),
                    const SizedBox(height: 24),

                    // C. Description Body
                    const Text("Details", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Text(
                      notice.otherDetails.isEmpty ? "No additional details provided." : notice.otherDetails,
                      style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.6),
                    ),

                    const SizedBox(height: 40),

                    // --- BUTTON FUNCTIONALITY: Action Buttons (Only show if links exist) ---
                    if (notice.rulebookPdfUrl.isNotEmpty || notice.registrationLink.isNotEmpty) ...[
                      const Divider(color: Color(0xFF1E293B), thickness: 1),
                      const SizedBox(height: 24),

                      if (notice.rulebookPdfUrl.isNotEmpty)
                        _buildActionButton(Icons.picture_as_pdf, "View Rulebook (PDF)", const Color(0xFFEF4444), () async {
                          // Launch PDF URL
                          await _launchUrl(notice.rulebookPdfUrl, context);
                        }),

                      if (notice.rulebookPdfUrl.isNotEmpty && notice.registrationLink.isNotEmpty)
                        const SizedBox(height: 12),

                      if (notice.registrationLink.isNotEmpty)
                        _buildActionButton(Icons.link, "Register Now", const Color(0xFF3B82F6), () async {
                          // Launch Registration Link
                          await _launchUrl(notice.registrationLink, context);
                        }),
                    ],
                    // ------------------------------------------------------------------------
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to handle URL launching safely
  Future<void> _launchUrl(String url, BuildContext context) async {
    if (url.isEmpty) return; // Should not happen with current logic, but safe.
    final Uri uri = Uri.parse(url);
    try {
      // Try to launch in an external application (the device's browser or PDF viewer)
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open link: $url')),
        );
      }
    }
  }

  // Helper Widget for date pills
  Widget _buildInfoPill(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // Helper Widget for action buttons
  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.15),
          foregroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: color.withOpacity(0.5)),
          ),
        ),
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}