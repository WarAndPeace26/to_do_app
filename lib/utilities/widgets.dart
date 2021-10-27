import 'package:flutter/material.dart';
import 'dart:math' as math;
class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: SizedBox(
      height: 60,
      width: 120,

      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      ),
    ),
  );
}
class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      heading,
      style: const TextStyle(fontSize: 24),
    ),
  );
}

class SliverHeadBarDelegate extends SliverPersistentHeaderDelegate{
  SliverHeadBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(SliverHeadBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}


Column onBoardPage(String img, String title, String detail, BuildContext context)
{
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        height: 20,
      ),
      Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/image/$img.png'),
            )
        ),
      ),
      const SizedBox(height: 50,),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(title, style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500
        ),),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Text(detail, style: const TextStyle(
            fontSize: 16,
            color: Colors.grey
        ),textAlign: TextAlign.center,),
      )
    ],
  );
}

