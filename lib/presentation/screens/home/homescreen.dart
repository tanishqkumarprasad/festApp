import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/button.dart';
import '../../../data/models/event_model.dart';
import '../../../logic/bloc/event/event_bloc.dart';
import '../../../logic/bloc/event/event_state.dart';
import '../student/upcoming_events_page.dart';
import '../student/notices_screen.dart';
import '../profile/profile_page.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBackground = Color(0xFF020617);
    const cardBackground = Color(0xFF0F172A);
    const pillBackground = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 24),
              BlocBuilder<EventBloc, EventState>(
                builder: (BuildContext context, EventState state) {
                  if (state is EventLoading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LiveEventHero(
                          backgroundColor: cardBackground,
                          pillBackground: pillBackground,
                          isLoading: true,
                        ),
                        const SizedBox(height: 32),
                        _buildUpcomingHeader(context),
                        const SizedBox(height: 16),
                        const Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }

                  if (state is EventError) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LiveEventHero(
                          backgroundColor: cardBackground,
                          pillBackground: pillBackground,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is EventEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LiveEventHero(
                          backgroundColor: cardBackground,
                          pillBackground: pillBackground,
                        ),
                        const SizedBox(height: 32),
                        _buildUpcomingHeader(context),
                        const SizedBox(height: 16),
                        const Text(
                          'No events yet. Stay tuned!',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    );
                  }

                  if (state is EventLoaded) {
                    final List<EventModel> events = state.events;
                    if (events.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LiveEventHero(
                            backgroundColor: cardBackground,
                            pillBackground: pillBackground,
                          ),
                          const SizedBox(height: 32),
                          _buildUpcomingHeader(context),
                          const SizedBox(height: 16),
                          const Text(
                            'No events yet. Stay tuned!',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      );
                    }

                    EventModel? heroEvent;
                    for (final EventModel e in events) {
                      if (e.isLive) {
                        heroEvent = e;
                        break;
                      }
                    }
                    heroEvent ??= events.first;

                    final List<EventModel> upcoming = events
                        .where((EventModel e) => e != heroEvent)
                        .toList(growable: false);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LiveEventHero(
                          backgroundColor: cardBackground,
                          pillBackground: pillBackground,
                          event: heroEvent,
                        ),
                        const SizedBox(height: 32),
                        _buildUpcomingHeader(context),
                        const SizedBox(height: 16),
                        if (upcoming.isEmpty)
                          const Text(
                            'No more upcoming events.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          )
                        else
                          Column(
                            children: [
                              for (final EventModel e in upcoming) ...[
                                _UpcomingEventCard.fromEvent(e),
                                const SizedBox(height: 16),
                              ],
                            ],
                          ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          final events = state is EventLoaded ? state.events : <EventModel>[];
          return _StudentBottomNavBar(events: events);
        },
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.appName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const ProfilePage(),
              ),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1E293B),
            ),
            child: const Icon(Icons.person_outline, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Upcoming Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        AppButton(
          text: 'See All',
          variant: AppButtonVariant.text,
          size: AppButtonSize.small,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _LiveEventHero extends StatelessWidget {
  final Color backgroundColor;
  final Color pillBackground;
  final EventModel? event;
  final bool isLoading;

  const _LiveEventHero({
    required this.backgroundColor,
    required this.pillBackground,
    this.event,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool showLive = event?.isLive ?? true;
    final String title;
    final String subtitle;

    if (isLoading) {
      title = 'Loading event...';
      subtitle = '';
    } else if (event != null) {
      title = event!.title.isNotEmpty ? event!.title : 'Live event';
      subtitle = _subtitleForEvent(event!);
    } else {
      title = "Pratibimb '26";
      subtitle = 'Stay tuned for upcoming events';
    }

    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -60,
            top: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            left: -40,
            bottom: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showLive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: pillBackground.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, size: 8, color: AppColors.redAlert),
                        SizedBox(width: 6),
                        Text(
                          'LIVE NOW',
                          style: TextStyle(
                            color: AppColors.surface,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: showLive ? 16 : 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.surface,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                const Spacer(),
                AppButton(
                  text: 'Join',
                  variant: AppButtonVariant.secondary,
                  size: AppButtonSize.medium,
                  width: 120,
                  borderRadius: BorderRadius.circular(16),
                  isDisabled: isLoading,
                  onPressed: isLoading ? null : () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _subtitleForEvent(EventModel event) {
    final DateTime? start = event.startAt;
    final DateTime? end = event.endAt;

    String timePart = '';
    if (start != null && end != null) {
      timePart = '${_formatTime(start)} - ${_formatTime(end)}';
    } else if (start != null) {
      timePart = _formatTime(start);
    }

    final String location = event.category;
    if (location.isNotEmpty && timePart.isNotEmpty) {
      return '$location · $timePart';
    }
    if (location.isNotEmpty) return location;
    if (timePart.isNotEmpty) return timePart;
    return '';
  }

  String _formatTime(DateTime date) {
    final int hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final String minute = date.minute.toString().padLeft(2, '0');
    final String period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $period';
  }
}

class _UpcomingEventCard extends StatelessWidget {
  final String day;
  final String month;
  final String title;
  final String location;
  final String time;

  const _UpcomingEventCard({
    required this.day,
    required this.month,
    required this.title,
    required this.location,
    required this.time,
  });

  factory _UpcomingEventCard.fromEvent(EventModel event) {
    final DateTime? date = event.startAt;
    final String day = date != null
        ? date.day.toString().padLeft(2, '0')
        : '--';
    final String month = date != null ? _monthAbbreviation(date.month) : '--';

    String time;
    if (date != null) {
      final String h = date.hour.toString().padLeft(2, '0');
      final String m = date.minute.toString().padLeft(2, '0');
      time = '$h:$m';
    } else {
      time = 'Time TBD';
    }

    final String location = event.category.isNotEmpty
        ? event.category
        : 'Campus';

    return _UpcomingEventCard(
      day: day,
      month: month,
      title: event.title,
      location: location,
      time: time,
    );
  }

  static String _monthAbbreviation(int month) {
    const List<String> months = <String>[
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    if (month < 1 || month > 12) return '--';
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  month,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentBottomNavBar extends StatelessWidget {
  const _StudentBottomNavBar({required this.events});

  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF020617),
        border: Border(top: BorderSide(color: Color(0xFF1E293B), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _NavItem(
            icon: Icons.home_filled,
            label: 'Home',
            isActive: true,
          ),
          _NavItem(
            icon: Icons.calendar_month,
            label: 'Upcoming',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const UpcomingEventsPage(),
                ),
              );
            },
          ),
          const _NavItem(icon: Icons.info_outline, label: 'About Us'),
          _NavItem(
            icon: Icons.notifications_none,
            label: 'Notice',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const NoticesScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.surface : Colors.white54;
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 11)),
      ],
    );
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: content,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: content,
    );
  }
}
