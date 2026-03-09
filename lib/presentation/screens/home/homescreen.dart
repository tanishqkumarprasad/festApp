import 'package:fest_app/presentation/screens/about_us/about_us_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/button.dart';
import '../../../data/models/event_model.dart';
import '../../../data/providers/event_data_provider.dart';
import '../../../logic/bloc/event/event_bloc.dart';
import '../../../logic/bloc/event/event_state.dart';
import '../../widgets/top_events_section.dart';
import '../student/upcoming_events_page.dart';
import '../student/notices_screen.dart';
import '../profile/profile_page.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  List<EventModel> _fallbackUpcomingEvents() {
    final upcoming = EventDataProvider.getUpcomingEvents(limit: 20);
    return upcoming
        .map(
          (u) => EventModel(
            id: '${u.eventName}-${u.eventDate.toIso8601String()}',
            title: u.eventName,
            club: 'general',
            category: u.campus,
            status: 'upcoming',
            startAt: u.eventDate,
            endAt: null,
          ),
        )
        .toList(growable: false);
  }

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
                    final fallback = _fallbackUpcomingEvents();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LiveEventHero(
                          backgroundColor: cardBackground,
                          pillBackground: pillBackground,
                          isLoading: true,
                        ),
                        const SizedBox(height: 32),
                        TopEventsSection(
                          title: 'Upcoming Events',
                          events: fallback,
                          limit: 5,
                          isLoading: true,
                          onSeeAllTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const UpcomingEventsPage(),
                              ),
                            );
                          },
                        ),
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
                    final fallback = _fallbackUpcomingEvents();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LiveEventHero(
                          backgroundColor: cardBackground,
                          pillBackground: pillBackground,
                        ),
                        const SizedBox(height: 32),
                        TopEventsSection(
                          title: 'Upcoming Events',
                          events: fallback,
                          limit: 5,
                          onSeeAllTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const UpcomingEventsPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }

                  if (state is EventLoaded) {
                    final List<EventModel> events = state.events;
                    if (events.isEmpty) {
                      final fallback = _fallbackUpcomingEvents();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LiveEventHero(
                            backgroundColor: cardBackground,
                            pillBackground: pillBackground,
                          ),
                          const SizedBox(height: 32),
                          TopEventsSection(
                            title: 'Upcoming Events',
                            events: fallback,
                            limit: 5,
                            onSeeAllTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const UpcomingEventsPage(),
                                ),
                              );
                            },
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
                    final fallback = _fallbackUpcomingEvents();
                    final List<EventModel> topEvents =
                        upcoming.isNotEmpty ? upcoming : fallback;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LiveEventHero(
                          backgroundColor: cardBackground,
                          pillBackground: pillBackground,
                          event: heroEvent,
                        ),
                        const SizedBox(height: 32),
                        TopEventsSection(
                          title: 'Upcoming Events',
                          events: topEvents,
                          limit: 5,
                          onSeeAllTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const UpcomingEventsPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 32),
              _MessageSection(
                imagePath: 'assets/images/Directorimage1.jpeg',
                title: 'Message from the Director’s Desk',
                designation: 'Dr. PK Jain, Director, NIT Patna',
                message:
                    'At our institute, we believe that true education extends beyond classrooms. Cultural, sports, and literary activities play a vital role in shaping confident, creative, and responsible individuals. The Student Activity Centre app is a step towards encouraging students to explore their talents, participate actively, and grow through diverse learning experiences.',
                backgroundColor: cardBackground,
                pillBackground: pillBackground,
              ),
              const SizedBox(height: 32),
              _MessageSection(
                imagePath: 'assets/images/DSW image1.jpeg',
                title: 'Message from Fest President',
                designation: 'Dr. Prabhat Kumar, Dean Student Welfare',
                message:
                    'It gives me great pleasure to see the Student Activity Centre App becoming an integral part of our fest. The app has enabled seamless event updates and registrations, making participation easier for everyone. It reflects our commitment to creating an organized, engaging, and vibrant platform for students to celebrate talent and teamwork.',
                backgroundColor: cardBackground,
                pillBackground: pillBackground,
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

  // Widget _buildUpcomingHeader(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       const Text(
  //         'Upcoming Events',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 18,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       AppButton(
  //         text: 'See All',
  //         variant: AppButtonVariant.text,
  //         size: AppButtonSize.small,
  //         onPressed: () {},
  //       ),
  //     ],
  //   );
  // }
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
    final String title = 'Mixed Cricket';
    final String subtitle = 'at venue SAC ground';

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
                  text: 'Reach now',
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
            label: 'Events',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const UpcomingEventsPage(),
                ),
              );
            },
          ),
          _NavItem(
            icon: Icons.info_outline,
            label: 'About Us',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const AboutUsPage(),
                ),
              );
            },
          ),
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

class _MessageSection extends StatelessWidget {
  final String imagePath;
  final String title;
  final String designation;
  final String message;
  final Color backgroundColor;
  final Color pillBackground;

  const _MessageSection({
    required this.imagePath,
    required this.title,
    required this.designation,
    required this.message,
    required this.backgroundColor,
    required this.pillBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: pillBackground, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: pillBackground, width: 2),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
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
                        color: AppColors.surface,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      designation,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
