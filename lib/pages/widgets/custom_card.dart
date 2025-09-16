import 'package:flutter/material.dart';
import 'package:manse_app/constants/assets.dart';
import 'package:manse_app/pages/widgets/animation.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;

  const CustomCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive calculations
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final imageSize = isSmallScreen ? screenWidth * 0.35 : 160.0;
    final padding = isSmallScreen ? 8.0 : 12.0;
    final fontSizeTitle = isSmallScreen ? 14.0 : 16.0;
    final fontSizeDescription = isSmallScreen ? 12.0 : 14.0;
    final iconSize = isSmallScreen ? 24.0 : 30.0;

    return SlideAnimation(
      from: SlideFrom.bottom,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: padding,
          horizontal: isSmallScreen ? 8.0 : 0.0,
        ),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image section with responsive width
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.deepOrange,
              ),
              child: Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: isSmallScreen ? 8.0 : 16.0),

            // Text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: fontSizeTitle,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isSmallScreen ? 4.0 : 8.0),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: fontSizeDescription,
                      color: Colors.black87,
                    ),
                    maxLines: isSmallScreen ? 3 : 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.facebook,
                        color: const Color.fromARGB(255, 33, 103, 243),
                        size: iconSize,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:manse_app/constants/assets.dart';
// import 'package:manse_app/pages/widgets/animation.dart';

// class CustomCard extends StatelessWidget {
//   const CustomCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SlideAnimation(
//       from: SlideFrom.bottom,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 8,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Image section with fixed width
//             Container(
//               width: 160,
//               height: 160,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.deepOrange,
//               ),
//               child: Container(
//                 width: 160,
//                 height: 160,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   image: DecorationImage(
//                     image: AssetImage(Assets.assetsImagesRaj),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),

//             // Text section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "RAJ THACKERAY",
//                     style: Theme.of(
//                       context,
//                     ).textTheme.headlineLarge?.copyWith(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "This is a description or content inside the card. You can customize it as needed.",
//                     style: TextStyle(fontSize: 14, color: Colors.black87),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Icon(
//                         Icons.facebook,
//                         color: const Color.fromARGB(255, 33, 103, 243),
//                         size: 30,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
