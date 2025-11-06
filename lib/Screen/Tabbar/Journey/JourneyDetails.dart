import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';

class JourneyDetailsScreen extends StatefulWidget {
  final String title;
  final String imagePath;

  const JourneyDetailsScreen({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<JourneyDetailsScreen> createState() => _JourneyDetailsScreenState();
}

class _JourneyDetailsScreenState extends State<JourneyDetailsScreen> {
  final List<String> mediaImages = [
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
  ];

  final List<Map<String, String>> offers = [
    {
      "title": "10% OFF your romantic pastry set",
      "subtitle": "Code: LOVE10 (valid today only)",
    },
    {
      "title": "Buy 2 pastries, get 1 mini tart free",
      "subtitle": "Show this offer to the cashier at checkout\nCode: TREATME (Today until 6:00)",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/backArrow.png", height: 26, width: 26),
                      const SizedBox(width: 10),
                      Text(
                        'Journey',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: App_BlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/shop.png',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Bäckerei Herzstück",
                        style: TextStyle(
                          color: App_BlackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset('assets/locationPin.png', height: 15, width: 15),
                        const SizedBox(width: 6),
                        const Text(
                          "1.5 Km",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/disableLocation.png', height: 18, width: 18),
                        const SizedBox(width: 4),
                        Text(
                          "Hofgeismar Old Town, Germany",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: App_Location,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/start.png', height: 15, width: 15),
                        const SizedBox(width: 6),
                        const Text(
                          "4.2",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        color: App_DescText,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Bäckerei Herzstück is a cozy, locally loved bakery known for its seasonal fairy tale specials. Step inside for sweet moments, soft music, and fresh aromas.",
                      style: TextStyle(
                        color: App_BlackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Multimedia",
                  style: TextStyle(
                    color: App_DescText,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 95,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: mediaImages.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        mediaImages[index],
                        width: 100,
                        height: 95,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Opening Hours",
                  style: TextStyle(
                    color: App_DescText,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "10:00 – 18:00 (Daily)",
                  style: TextStyle(
                    color: App_BlackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 18),
          // Offers Section

      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Offers",
            style: TextStyle(
              color: App_BlackColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),

          // List of Offers
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: offers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/discount.png", height: 32, width: 32),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer["title"]!,
                            style: TextStyle(
                              color: App_BlackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: App_DescText,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            height: 1.3,
                          ),
                          children: [
                            const TextSpan(text: "Code: "),
                            TextSpan(
                              text: "LOVE10",
                              style: const TextStyle(fontWeight: FontWeight.w600), // bold only LOVE10
                            ),
                            const TextSpan(text: " (valid today only)"),
                          ],
                        ),
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // centers vertically
              children: [
                Image.asset("assets/coin.png", height: 32, width: 32),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    "You will Earn 100 Points by visiting there",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: App_BlackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
