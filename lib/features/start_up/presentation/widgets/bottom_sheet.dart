import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddIdeaBottomSheet extends StatefulWidget {
  const AddIdeaBottomSheet({super.key});

  @override
  State<AddIdeaBottomSheet> createState() => _AddIdeaBottomSheetState();
}

class _AddIdeaBottomSheetState extends State<AddIdeaBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _progressController = TextEditingController();
  bool _isSubmitting = false;

// Inside your _submit method in AddIdeaBottomSheet:
Future<void> _submit() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isSubmitting = true);
    
    try {
      await FirebaseFirestore.instance.collection('investments').add({
        'title': _titleController.text,
        'description': _descController.text,
        'amount': double.tryParse(_amountController.text) ?? 0.0,
        'progress': double.tryParse(_progressController.text) ?? 0.0,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Notify parent to refresh
      if (mounted) {
        Navigator.pop(context, true); // Pass true to indicate success
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add New Idea",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              const Divider(),
              SizedBox(height: 16.h),

              // Title Field
              Text(
                "Idea Title",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Enter idea title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
                style: TextStyle(fontSize: 14.sp),
                validator: (val) => val!.isEmpty ? "Title is required" : null,
              ),
              SizedBox(height: 16.h),

              // Description Field
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Describe your idea in detail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
                style: TextStyle(fontSize: 14.sp),
                validator: (val) => val!.isEmpty ? "Description is required" : null,
              ),
              SizedBox(height: 16.h),

              // Amount and Progress in Row
              Row(
                children: [
                  // Amount Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount (EGP)",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "0.00",
                            prefixIcon: const Icon(Icons.attach_money),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.sp),
                          validator: (val) => val!.isEmpty ? "Enter amount" : null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // Progress Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Progress (%)",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _progressController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "0-100",
                            prefixIcon: const Icon(Icons.trending_up),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.sp),
                          validator: (val) => val!.isEmpty ? "Enter progress" : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Submit Idea",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _amountController.dispose();
    _progressController.dispose();
    super.dispose();
  }
}