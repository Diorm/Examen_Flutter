import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final VoidCallback onTap;
  final String element;
  final String iconele;
  final int nbretype1;
  final int nombretype2;
  final Color color;
  final int totalele;
  final String type1;
  final String type2;

  const MyCard({super.key, 
    required this.onTap,
    required this.element,
    required this.iconele,
    required this.nbretype1,
    required this.nombretype2,
    required this.color,
    required this.totalele,
    required this.type1,
    required this.type2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Image.asset(
                            iconele,
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '$totalele',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$nbretype1 $type1',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$nombretype2 $type2',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
