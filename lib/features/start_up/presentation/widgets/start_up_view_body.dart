import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/start_up/presentation/widgets/add_new_buttom_idea.dart';

class StartUpViewBody extends StatefulWidget {
  const StartUpViewBody({super.key});

  @override
  State<StartUpViewBody> createState() => _StartUpViewBodyState();
}

class _StartUpViewBodyState extends State<StartUpViewBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _ideas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchIdeas();
  }

  Future<void> _fetchIdeas() async {
    try {
      final snapshot = await _firestore.collection('investments').get();
      setState(() {
        _ideas = snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            "id": doc.id,
            "name": data['title'] ?? 'No Title',
            "image": Assets.imagesLogoInCaed,
            "price": "\$${data['amount']?.toStringAsFixed(2) ?? '0.00'}",
            "progress": (data['progress'] ?? 0.0) / 100.0,
            "description": data['description'] ?? 'No description',
            "cardColor": _getRandomCardColor(),
          };
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching ideas: ${e.toString()}')),
      );
    }
  }

  Color _getRandomCardColor() {
    final colors = [
      const Color(0xFFF9E8C9),
      const Color(0xFFDCEBF6),
      const Color(0xFFE8F5E9),
      const Color(0xFFF3E5F5),
    ];
    return colors[_ideas.length % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          AddNewIdeaButton(onIdeaAdded: _fetchIdeas),
          SizedBox(height: 16.h),
          
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_ideas.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  "No ideas yet. Tap the button above to add your first idea!",
                  style: TextStyle(fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _ideas.length,
                itemBuilder: (context, index) {
                  final idea = _ideas[index];
                  return _buildIdeaCard(idea);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIdeaCard(Map<String, dynamic> idea) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: () => _showEditDialog(idea['id']),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: idea["cardColor"],
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.r,
                offset: Offset(0, 3.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30.r,
                    child: Image.asset(
                      idea["image"]!,
                      width: 30.w,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showEditDialog(idea['id']),
                    icon: Icon(Icons.edit, size: 20.sp),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                idea["name"]!,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                idea["price"]!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                idea["description"]!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),
              LinearProgressIndicator(
                value: idea["progress"],
                backgroundColor: Colors.grey[300],
                color: Colors.black,
              ),
              SizedBox(height: 4.h),
              Text(
                "${(idea["progress"] * 100).toInt()}% In Progress",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorInProgress,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(String ideaId) {
    // Implement edit functionality here
  }
}