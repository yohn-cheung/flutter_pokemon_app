import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Detailscreen extends StatefulWidget {
  const Detailscreen({super.key});

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail paage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadTabs(
              value: 'description',
              // tabBarConstraints: const BoxConstraints(maxWidth: 400),
              // contentConstraints: const BoxConstraints(maxWidth: 400),
              tabs: [
                ShadTab(
                  value: 'description',
                  content: ShadCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        ShadInputFormField(
                          label: const Text('Name'),
                          initialValue: 'Ale',
                        ),
                        const SizedBox(height: 8),
                        ShadInputFormField(
                          label: const Text('Username'),
                          initialValue: 'nank1ro',
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  child: const Text('Account'),
                ),
                ShadTab(
                  value: 'stats',
                  content: ShadCard(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ShadInputFormField(
                          label: const Text('Current password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 8),
                        ShadInputFormField(
                          label: const Text('New password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  child: const Text('Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
