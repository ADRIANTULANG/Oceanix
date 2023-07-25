import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/pmr_controller.dart';

class PMRview extends GetView<PMRController> {
  const PMRview({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PMRController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Preserving Marine Resources',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Here are some important do's and don'ts to consider for the preservation of marine resources",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Do's",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Practice Sustainable Fishing",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  "Practice Sustainable Fishing: Adhere to catch limits, use selective fishing gear, and follow responsible fishing practices that minimize bycatch and avoid harm to non-target species.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Support Sustainable Seafood",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  "Choose seafood from sustainable sources and look for certifications such as Marine Stewardship Council (MSC) or Aquaculture Stewardship Council (ASC) to ensure responsible fishing and farming practices.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Respect Marine Protected Areas (MPAs)",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  "Observe and follow regulations when entering MPAs, avoid fishing or any activities that could damage sensitive habitats, and contribute to the conservation efforts of these protected areas.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Conserve Energy and Water",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  "Reduce energy consumption and water usage in daily activities, both on land and on boats, to minimize the carbon footprint and environmental impact.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Don'ts",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Overfish or Engage in Illegal Fishing",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  "Avoid exceeding catch limits, engaging in overfishing practices, or participating in illegal, unreported, and unregulated (IUU) fishing activities that can harm fish populations and ecosystems.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Harm Marine Life or Habitats",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  " Do not disturb or harm marine life, including corals, seagrasses, and other sensitive habitats. Avoid practices like anchoring on coral reefs or feeding marine animals, as they can disrupt natural behaviors and ecosystems.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Dispose of Waste in the Ocean",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  "Never throw garbage, including plastics, fishing gear, or any other waste, into the ocean. Properly manage waste by recycling, disposing of it in designated areas, or utilizing proper waste management systems.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Use Harmful Chemicals",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  "Avoid using harmful chemicals, such as certain pesticides or cleaning agents, that can pollute the water and harm marine life.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Neglect Environmental Regulations",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(
                  "Comply with environmental regulations, fishing quotas, and other legal requirements put in place to protect marine resources. Stay informed about local regulations and ensure compliance to support sustainable practices.",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "These do's and don'ts serve as guidelines to promote responsible behavior and contribute to the conservation and preservation of marine resources.",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
