import 'package:flutter/material.dart';

import '../../../core/utils/person_card.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> people = [
      {
        'name': 'Dishant Kumar Patel',
        'email': 'dishantp.ug24.ce@nitp.ac.in',
        'phone': '7073421006',
      },
      {
        'name': 'Niranjan S',
        'email': 'niranjans.ug23.ar@nitp.ac.in',
        'phone': '9188394053',
      },
      {
        'name': 'Daksh Agrawal',
        'email': 'daksha.ug23.ce@nitp.ac.in',
        'phone': '7737376294',
      },
      {
        'name': 'KRISH KUMAR SINHA',
        'email': 'krishs.ug23.ar@nitp.ac.in',
        'phone': '7061896463',
      },
      {
        'name': 'Prajwal akki',
        'email': 'prajwala.ug25.ce@nitp.ac.in',
        'phone': '8147950295',
      },
      {
        'name': 'Shanvi Dixit',
        'email': 'shanvid.ug23.ch@nitp.ac.in',
        'phone': '8810904010',
      },
      {
        'name': 'Sidram',
        'email': 'Sidramd.ug23.ar@nitp.ac.in',
        'phone': '9353029255',
      },
      {
        'name': 'Satyam Kumar',
        'email': 'satyamk.ug24.ce@nitp.ac.in',
        'phone': '7765976599',
      },
      {
        'name': 'Anusha Mitra',
        'email': 'anusham.ug23.ar@nitp.ac.in',
        'phone': '6290552969',
      },
      {
        'name': 'Suhani',
        'email': 'Suhani.ug23.ar@nitp.ac.in',
        'phone': '7292015147',
      },
      {
        'name': 'Aparna singh',
        'email': 'aparnas.ug23.ar@nitp.ac.in',
        'phone': '9234758623',
      },
      {
        'name': 'Vinayak kumar',
        'email': 'vinayakk.ug23.ee@nitp.ac.in',
        'phone': '6299099156',
      },
      {
        'name': 'Rohit Kumar',
        'email': 'rohitk.ug24.ce@nitp.ac.in',
        'phone': '7281903256',
      },
      {
        'name': 'Subhadeep Dey',
        'email': 'subhadeepd.ug23.ar@nitp.ac.in',
        'phone': '7047963335',
      },
      {
        'name': 'Shivang Shukla',
        'email': 'shivangs.ug23.ce@nitp.ac.in',
        'phone': '7007154261',
      },
      {
        'name': 'Aditi Jayesh Rao',
        'email': 'aditir.ug22.ar@nitp.ac.in',
        'phone': '6264767138',
      },
      {
        'name': 'Rohit Kumar',
        'email': 'rohitk.ug24.ce@nitp.ac.in',
        'phone': '7281903256',
      },
      {
        'name': 'Nitin Tiwari',
        'email': 'nitint.ug24.me@nitp.ac.in',
        'phone': '9555631830',
      },
      {
        'name': 'Saksham kumar',
        'email': 'sakshamk.ug24.ar@nitp.ac.in',
        'phone': '6299446166',
      },
      {
        'name': 'Jyoti Kumari',
        'email': 'jyotik.ug23.ar@nitp.ac',
        'phone': '9905657081',
      },
      {
        'name': 'Rahul Kumar',
        'email': 'rahulk.ug24.ce@nitp.ac.in',
        'phone': '9608304214',
      },
      {
        'name': 'Sania Kumari',
        'email': 'saniak.ug23.ch@nitp.ac.in',
        'phone': '7488906485',
      },
      {
        'name': 'Bhanu Priya',
        'email': 'bhanup.ug23.ce@nitp.ac.in',
        'phone': '8235976798',
      },
      {
        'name': 'Deepali Mishra',
        'email': 'deepalim.ug24.me@nitp.ac.in',
        'phone': '7428485611',
      },
      {
        'name': 'Aditi Verma',
        'email': 'aditiv.ug23.me@nitp.ac.in',
        'phone': '7318552617',
      },
      {
        'name': 'Anurag Mishra',
        'email': 'anuragm.ug24.cs@nitp.ac.in',
        'phone': '7061633407',
      },
      {
        'name': 'Mitali Raj',
        'email': 'mitalir.ug24.ce@nitp.ac.in',
        'phone': '6204580397',
      },
      {
        'name': 'Satyam Tiwari',
        'email': 'satyamt.dd24.me@nitp.ac.in',
        'phone': '7545924508',
      },
      {
        'name': 'TABASSUM BANERJEE',
        'email': 'tabassumb.ug24.ar@nitp.ac.in',
        'phone': '8170919828',
      },
      {
        'name': 'Abhisth Vitan Ambasth',
        'email': 'Abhistha.ug24.ar@nitp.ac.in',
        'phone': '9973555357',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            final person = people[index];
            return PersonCard(
              name: person['name']!,
              email: person['email']!,
              phone: person['phone']!,
            );
          },
        ),
      ),
    );
  }
}
