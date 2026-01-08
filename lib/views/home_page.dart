import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl_mobile_field/intl_mobile_field.dart';
import 'package:sayhi/config/routes.dart';
import '../controllers/message_controller.dart';
import '../controllers/history_controller.dart';
import '../constants/colors.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<String> _messageSuggestions = [
    '👋',
    '🙏',
    'Hi',
    'Hello',
    'Namaste',
    'Hey',
    'Good Morning',
    'Good Afternoon',
    'Good Evening',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryTeal,
        title: Text(
          "SayHi",

          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.drawer);
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      // Header Section
                      // Text(
                      //   'SayHi',
                      //   style: Theme.of(context).textTheme.headlineLarge
                      //       ?.copyWith(
                      //         fontWeight: FontWeight.bold,
                      //         color: Theme.of(context).colorScheme.onSurface,
                      //       ),
                      //   textAlign: TextAlign.center,
                      // ),
                      // const SizedBox(height: 8),
                      // Text(
                      //   'Direct Message to WhatsApp',
                      //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      //     color: Theme.of(
                      //       context,
                      //     ).colorScheme.onSurface.withOpacity(0.7),
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      const SizedBox(height: 40),

                      // Mobile Number Field with Country Code
                      Text(
                        'Mobile Number',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Consumer<MessageController>(
                        builder: (context, controller, child) {
                          return IntlMobileField(
                            controller: _phoneController,
                            disableLengthCounter: false,
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              controller.updatePhoneNumber(
                                phone.completeNumber,
                              );
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outline.withOpacity(0.8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          );
                        },
                      ),

                      // Message Field
                      Text(
                        'Message (optional)',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Consumer<MessageController>(
                        builder: (context, controller, child) {
                          final hasText = controller.message.message.isNotEmpty;
                          return TextField(
                            controller: _messageController,
                            onChanged: (value) {
                              controller.updateMessage(value);
                            },
                            maxLines: 1,
                            maxLength: null, // Remove character limit
                            buildCounter:
                                (
                                  context, {
                                  required currentLength,
                                  required isFocused,
                                  maxLength,
                                }) => null, // Hide character counter
                            decoration: InputDecoration(
                              hintText: 'Type your message here...',
                              alignLabelWithHint: true,
                              hintStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.5),
                                  ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outline.withOpacity(0.5),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              suffixIcon: hasText
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.6),
                                      ),
                                      onPressed: () {
                                        _messageController.clear();
                                        controller.updateMessage('');
                                      },
                                    )
                                  : null,
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      // Message Suggestions
                      SizedBox(
                        height: 40,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _messageSuggestions.map((suggestion) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Consumer<MessageController>(
                                  builder: (context, controller, child) {
                                    return InkWell(
                                      onTap: () {
                                        final currentText =
                                            _messageController.text;
                                        final newText = currentText.isEmpty
                                            ? suggestion
                                            : '$currentText $suggestion';
                                        _messageController.text = newText;
                                        controller.updateMessage(newText);
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer
                                              // ignore: deprecated_member_use
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: Theme.of(
                                              context,
                                              // ignore: deprecated_member_use
                                            ).colorScheme.primary.withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(suggestion),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // History Section
                      Text(
                        'History',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Consumer<HistoryController>(
                        builder: (context, historyController, child) {
                          final uniqueHistory = historyController.history;

                          if (uniqueHistory.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'No history yet',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withOpacity(0.5),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return SizedBox(
                            height: 200,
                            child: ListView.separated(
                              itemCount: uniqueHistory.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final historyItem = uniqueHistory[index];
                                return _buildHistoryItem(
                                  context,
                                  historyItem.phoneNumber,
                                  historyController,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Button - Fixed at bottom, moves with keyboard
              Container(
                padding: const EdgeInsets.all(24.0),

                child: SafeArea(
                  top: false,
                  child: Consumer<MessageController>(
                    builder: (context, controller, child) {
                      return ElevatedButton(
                        onPressed: controller.isLoading
                            ? null
                            : () async {
                                // Check if phone number is valid
                                if (!controller.message.isValid) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Please enter a number',
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }

                                final historyController =
                                    Provider.of<HistoryController>(
                                      context,
                                      listen: false,
                                    );
                                await controller.sendMessage(historyController);
                                // Note: WhatsApp will open in external app
                                // We don't reset the form here as user might want to try again
                                // Only clear if WhatsApp opened successfully (handled by controller)
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryTeal,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey.shade400,
                          disabledForegroundColor: Colors.grey.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 8),
                                  Text(
                                    'SayHi to WhatsApp',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.rocket_launch, size: 20),
                                ],
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    String phoneNumber,
    HistoryController historyController,
  ) {
    return Dismissible(
      key: Key(phoneNumber),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        historyController.deleteHistoryItem(phoneNumber);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Deleted from history'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Stack(
          children: [
            // Tap to fill phone number
            InkWell(
              onTap: () {
                // Phone number is already stored with country code format
                // Update the phone controller and message controller
                _phoneController.text = phoneNumber;
                final messageController = Provider.of<MessageController>(
                  context,
                  listen: false,
                );
                messageController.updatePhoneNumber(phoneNumber);
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: AppColors.primaryTeal,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            phoneNumber,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // More button
            Positioned(
              right: 4,
              child: PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  size: 18,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
                onSelected: (value) {
                  if (value == 'delete') {
                    historyController.deleteHistoryItem(phoneNumber);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Deleted from history'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete, size: 18, color: Colors.red),
                        const SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
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
