// import 'package:flutter/material.dart';
// import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
// import 'package:restaurant_owner/ui/widgets/custom_card.dart';
// import 'package:restaurant_owner/ui/widgets/show_order_details_dialog.dart';

// class ComplaintCard extends StatelessWidget {
//   const ComplaintCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomCard(
//       color: Colors.red[50],
//       hoverBorderColor: Colors.red,
//       child: SizedBox(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '#12',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           color: Colors.black87,
//                         ),
//                   ),
//                   Text(
//                     '19/04/2023',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           color: Colors.black,
//                         ),
//                   ),
//                 ],
//               ),
//               const Divider(
//                 height: 30,
//               ),
//               Text(
//                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et sapien eget sem ornare lacinia quis a sapien. Phasellus dictum ac elit quis bibendum. Pellentesque nec suscipit est. Aenean vel diam vel tellus posuere elementum. Suspendisse a nunc quis sem tempor varius ac id odio. In dignissim non risus ut accumsan. Vivamus in turpis et est suscipit imperdiet. Nam congue orci quis tortor tincidunt, non tincidunt lorem finibus. Duis dapibus mattis vestibulum. Sed id nunc sit amet ipsum tincidunt elementum id sed libero. Curabitur diam augue, scelerisque nec libero vitae, suscipit luctus ex. Pellentesque sodales auctor fermentum. Donec elementum, lorem in molestie ullamcorper, lacus risus tincidunt justo, vel finibus est turpis eu nulla. Cras tempus, tellus sit amet eleifend feugiat, velit ligula euismod orci, eget interdum risus risus non est.',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: Colors.black,
//                     ),
//               ),
//               const Divider(
//                 height: 30,
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: CustomActionButton(
//                   mainAxisSize: MainAxisSize.min,
//                   color: Colors.red[800]!,
//                   iconData: Icons.arrow_outward_outlined,
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => const ShowOrderDetailsDialog(),
//                     );
//                   },
//                   label: 'Order Details',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
