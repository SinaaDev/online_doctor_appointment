import 'package:flutter/material.dart';

class FirstAidListScreen extends StatelessWidget {
  final List<FirstAidItem> firstAidItems = [
    FirstAidItem(
      icon: Icons.local_hospital,
      title: 'CPR',
      details: 'CPR, or cardiopulmonary resuscitation, is an emergency lifesaving procedure performed when the heart stops beating. '
          'It involves chest compressions and rescue breaths to manually circulate blood and oxygen in the body. '
          'Steps for CPR:\n\n1. Ensure the scene is safe.\n2. Check for responsiveness.\n3. Call emergency services.\n4. '
          'Open the airway and check for breathing.\n5. Begin chest compressions and rescue breaths at a ratio of 30:2.\n'
          '6. Continue until medical help arrives or the person shows signs of life.\n\nIt is crucial to perform CPR promptly '
          'to increase the chances of survival.',
    ),
    FirstAidItem(
      icon: Icons.warning,
      title: 'Choking',
      details: 'Choking occurs when an object lodges in the throat or windpipe, blocking airflow. Quick response is vital.\n\n'
          'Signs of choking:\n\n1. Inability to speak.\n2. Difficulty breathing.\n3. Coughing weakly or not at all.\n4. '
          'Bluish skin color.\n\nSteps to help a choking person:\n\n1. Encourage them to cough if they can.\n2. Perform the '
          'Heimlich maneuver if they cannot cough, speak, or breathe.\n3. Call emergency services if necessary.\n\nFor infants, '
          'use back blows and chest thrusts instead of the Heimlich maneuver.',
    ),
    FirstAidItem(
      icon: Icons.local_fire_department,
      title: 'Burns',
      details: 'Burns are injuries caused by heat, chemicals, electricity, or radiation. They range from minor to severe.\n\n'
          'Types of burns:\n\n1. First-degree burns: Affect the outer layer of skin, causing redness and pain.\n2. Second-degree '
          'burns: Affect the outer and underlying skin layers, causing blisters, swelling, and severe pain.\n3. Third-degree '
          'burns: Extend through all skin layers, causing white or charred skin and numbness.\n\nFirst aid for burns:\n\n1. '
          'Cool the burn with running water for at least 10 minutes.\n2. Cover with a sterile, non-stick bandage or cloth.\n3. '
          'Do not apply ice, butter, or ointments.\n4. Seek medical help for severe burns.',
    ),
    FirstAidItem(
      icon: Icons.bug_report,
      title: 'Bee Stings',
      details: 'Bee stings can cause pain, swelling, and allergic reactions. Immediate care can reduce discomfort and prevent complications.\n\n'
          'Steps for treating bee stings:\n\n1. Remove the stinger by scraping it out with a flat object.\n2. Wash the area with soap and water.\n'
          '3. Apply a cold pack to reduce swelling.\n4. Take an antihistamine for itching and swelling.\n5. Monitor for signs of an allergic reaction, '
          'such as difficulty breathing, swelling of the face or throat, or hives. Seek emergency help if these occur.',
    ),
    FirstAidItem(
      icon: Icons.eco,
      title: 'Poisoning',
      details: 'Poisoning occurs when a person ingests, inhales, or comes into contact with harmful substances. Quick action can save lives.\n\n'
          'Common signs of poisoning:\n\n1. Nausea and vomiting.\n2. Abdominal pain.\n3. Difficulty breathing.\n4. Confusion or drowsiness.\n\n'
          'First aid for poisoning:\n\n1. Call emergency services or a poison control center immediately.\n2. Follow their instructions carefully.\n'
          '3. Do not induce vomiting unless advised by a professional.\n4. If the person is unconscious but breathing, place them in the recovery position.',
    ),
    FirstAidItem(
      icon: Icons.sports_kabaddi,
      title: 'Sprains',
      details: 'A sprain is an injury to the ligaments around a joint. It often occurs in the ankles, wrists, or knees, causing pain and swelling.\n\n'
          'Symptoms of sprains:\n\n1. Pain around the affected joint.\n2. Swelling and bruising.\n3. Difficulty moving the joint.\n\nFirst aid for sprains (R.I.C.E. method):\n\n'
          '1. Rest the injured limb.\n2. Ice the area to reduce swelling (20 minutes every 2 hours).\n3. Compress with an elastic bandage.\n4. Elevate the limb above heart level.\n'
          '5. Seek medical advice if pain and swelling persist.',
    ),
    FirstAidItem(
      icon: Icons.airline_seat_flat,
      title: 'Fainting',
      details: 'Fainting, or syncope, is a temporary loss of consciousness due to a drop in blood flow to the brain. It usually lasts a few seconds to a few minutes.\n\n'
          'Common causes:\n\n1. Dehydration.\n2. Standing up too quickly.\n3. Emotional stress.\n4. Low blood sugar.\n\nFirst aid for fainting:\n\n'
          '1. Lay the person flat on their back and elevate their legs.\n2. Loosen tight clothing.\n3. Ensure they have plenty of fresh air.\n'
          '4. If they do not regain consciousness within a minute, seek medical help.\n5. Once conscious, offer water and encourage them to sit up slowly.',
    ),
    FirstAidItem(
      icon: Icons.invert_colors,
      title: 'Nosebleeds',
      details: 'Nosebleeds are common and can be caused by dry air, injury, or allergies. They can be alarming but are usually not serious.\n\n'
          'Steps to stop a nosebleed:\n\n1. Sit up straight and lean slightly forward.\n2. Pinch the soft part of the nose shut with your thumb and index finger.\n'
          '3. Hold the pinch for 10-15 minutes without releasing pressure.\n4. Apply a cold pack to the nose and cheeks.\n'
          '5. Avoid lying down or tilting your head back.\n6. If bleeding persists for more than 20 minutes or is heavy, seek medical help.',
    ),
    FirstAidItem(
      icon: Icons.pest_control,
      title: 'Insect Bites',
      details: 'Insect bites can cause itching, swelling, and, in some cases, serious allergic reactions. Prompt first aid can alleviate symptoms.\n\n'
          'Steps for treating insect bites:\n\n1. Wash the area with soap and water.\n2. Apply a cold pack to reduce swelling and pain.\n'
          '3. Use over-the-counter antihistamines or hydrocortisone cream to relieve itching.\n4. Avoid scratching to prevent infection.\n'
          '5. Monitor for signs of an allergic reaction, such as difficulty breathing or swelling of the face and throat, and seek emergency help if necessary.',
    ),
    FirstAidItem(
      icon: Icons.local_pharmacy,
      title: 'Seizures',
      details: 'Seizures are sudden, uncontrolled electrical disturbances in the brain. They can cause changes in behavior, movements, and consciousness.\n\n'
          'First aid for seizures:\n\n1. Stay calm and ensure the person is in a safe place.\n2. Remove any nearby objects that could cause injury.\n'
          '3. Do not restrain the person or put anything in their mouth.\n4. Time the seizure; if it lasts longer than 5 minutes, call emergency services.\n'
          '5. After the seizure, place the person in the recovery position and stay with them until they are fully awake.',
    ),
    FirstAidItem(
      icon: Icons.local_dining,
      title: 'Food Poisoning',
      details: 'Food poisoning is caused by consuming contaminated food or water. Symptoms include nausea, vomiting, diarrhea, and abdominal pain.\n\n'
          'First aid for food poisoning:\n\n1. Encourage the person to drink plenty of fluids to prevent dehydration.\n2. Avoid solid foods until vomiting and diarrhea stop.\n'
          '3. Provide oral rehydration solutions if available.\n4. Seek medical help if symptoms are severe or persistent, or if the person shows signs of dehydration.',
    ),
    FirstAidItem(
      icon: Icons.accessibility_new,
      title: 'Fractures',
      details: 'A fracture is a break or crack in a bone. It can be caused by trauma, falls, or direct blows.\n\nSymptoms of fractures:\n\n1. Intense pain.\n2. Swelling and bruising.\n'
          '3. Deformity or inability to move the affected part.\n\nFirst aid for fractures:\n\n1. Immobilize the injured area using a splint or sling.\n2. Apply ice packs to reduce swelling.\n'
          '3. Do not try to realign the bone.\n4. Seek medical help immediately for proper diagnosis and treatment.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Aid & Primary Care'),
      ),
      body: ListView.builder(
        itemCount: firstAidItems.length,
        itemBuilder: (context, index) {
          final item = firstAidItems[index];
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class DetailScreen extends StatelessWidget {
  final FirstAidItem item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Icon(item.icon, size: 100),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              item.details,
              style: const TextStyle(fontSize: 16),
            ),
            // Add more sections and details here
          ],
        ),
      ),
    );
  }
}


class FirstAidItem {
  final IconData icon;
  final String title;
  final String details;

  FirstAidItem({required this.icon, required this.title, required this.details});
}
