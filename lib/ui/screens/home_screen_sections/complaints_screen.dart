// import 'package:flutter/material.dart';
// import 'package:restaurant_owner/ui/widgets/complaints/complaint_card.dart';

// class ComplaintsScreen extends StatefulWidget {
//   const ComplaintsScreen({super.key});

//   @override
//   State<ComplaintsScreen> createState() => _ComplaintsScreenState();
// }

// class _ComplaintsScreenState extends State<ComplaintsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 1000,
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Wrap(
//                   spacing: 20,
//                   runSpacing: 20,
//                   children: List<Widget>.generate(
//                     10,
//                     (index) => const ComplaintCard(),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
