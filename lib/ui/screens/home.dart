import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_owner/ui/screens/home_screen_sections/complaints_screen.dart';
import 'package:restaurant_owner/ui/screens/home_screen_sections/food_screen.dart';
import 'package:restaurant_owner/ui/screens/home_screen_sections/food_category_screen.dart';
import 'package:restaurant_owner/ui/screens/home_screen_sections/dashboard_and_order_screen.dart';
import 'package:restaurant_owner/ui/screens/home_screen_sections/suggestions_screen.dart';
import 'package:restaurant_owner/ui/screens/home_screen_sections/table_screen.dart';
import 'package:restaurant_owner/ui/screens/home_screen_sections/food_type_screen.dart';
import 'package:restaurant_owner/ui/screens/login_screen.dart';
import 'package:restaurant_owner/ui/widgets/change_password_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        if (Supabase.instance.client.auth.currentUser == null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => true,
          );
        }
      },
    );

    tabController = TabController(
      length: 7,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.green[700]!,
        ),
        centerTitle: true,
        title: Text(
          'Restaurant Owner',
          style: GoogleFonts.oswald(
            textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Logout',
                  message: 'Are you sure that you want to logout ?',
                  primaryButtonLabel: 'Logout',
                  primaryOnPressed: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => true,
                    );
                    await Supabase.instance.client.auth.signOut();
                  },
                  secondaryButtonLabel: 'Cancel',
                  secondaryOnPressed: () => Navigator.pop(context),
                ),
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          DashboardAndOrderScreen(),
          FoodCategoryScreen(),
          FoodTypeScreen(),
          FoodScreen(),
          TableScreen(),
          ComplaintsScreen(),
          SuggestionsScreen(),
        ],
      ),
      drawer: Material(
        color: Colors.green[50],
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "MENU",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.green[700],
                      ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Dashboard & Orders",
                  iconData: Icons.dashboard_customize_outlined,
                  onPressed: () {
                    tabController.animateTo(0);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 0,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Food Category",
                  iconData: Icons.category_outlined,
                  onPressed: () {
                    tabController.animateTo(1);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 1,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Food Type",
                  iconData: Icons.menu_book_outlined,
                  onPressed: () {
                    tabController.animateTo(2);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 2,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Food Item",
                  iconData: Icons.restaurant_menu_outlined,
                  onPressed: () {
                    tabController.animateTo(3);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 3,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Table",
                  iconData: Icons.table_restaurant_outlined,
                  onPressed: () {
                    tabController.animateTo(4);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 4,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Order Complaints",
                  iconData: Icons.report_outlined,
                  onPressed: () {
                    tabController.animateTo(5);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 5,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Suggestions",
                  iconData: Icons.reviews_outlined,
                  onPressed: () {
                    tabController.animateTo(6);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 6,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Change Password",
                  iconData: Icons.lock_open_outlined,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => const ChangePasswordDialog());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawerButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Function() onPressed;
  final bool isSelected;
  const CustomDrawerButton({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: isSelected ? Colors.green[800] : Colors.green[50],
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
