import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/upcoming_event_model.dart';
import '../../../data/providers/event_data_provider.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({super.key});

  @override
  State<UpcomingEventsPage> createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  static const _campuses = <String>['All', 'Patna', 'Bihta'];

  String _selectedCampus = 'All';

  List<UpcomingEventModel> _getFilteredEvents() {
    final events = EventDataProvider.allEvents;
    final now = DateTime.now();

    final filtered = events.where((event) {
      final isFutureDate = event.eventDate.isAfter(now);
      final matchesCampus =
          _selectedCampus == 'All' || event.campus == _selectedCampus;

      return isFutureDate && matchesCampus;
    }).toList();

    filtered.sort((a, b) => a.eventDate.compareTo(b.eventDate));

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Events')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildCampusFilterRow(),
          const Divider(height: 1),
          Expanded(
            child: _getFilteredEvents().isEmpty
                ? const Center(child: Text('No upcoming events found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: _getFilteredEvents().length,
                    itemBuilder: (context, index) {
                      final event = _getFilteredEvents()[index];
                      return _EventCard(event: event);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampusFilterRow() {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          ..._campuses.map(
            (campus) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(campus),
                selected: _selectedCampus == campus,
                onSelected: (_) {
                  setState(() {
                    _selectedCampus = campus;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final UpcomingEventModel event;

  Future<void> _launchRegistration() async {
    final url = Uri.parse(event.registrationLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    event.eventName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(event.campus),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 4),
                Text(
                  _formatDate(event.eventDate),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _launchRegistration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Register Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
