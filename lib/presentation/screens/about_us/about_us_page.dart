import 'package:flutter/material.dart';

import '../../../core/utils/person_card.dart';
import '../../../data/providers/team_data_provider.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedMembers = TeamDataProvider.getTeamMembersGroupedByTeam();
    final teams = groupedMembers.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: teams.length,
          itemBuilder: (context, index) {
            final team = teams[index];
            final members = groupedMembers[team]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    team,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...members.map((member) {
                  return PersonCard(
                    name: member.name,
                    role: member.role,
                    email: member.email!,
                    phone: member.phone!,
                  );
                }),
                const Divider(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }
}
