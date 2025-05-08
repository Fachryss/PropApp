import 'package:flutter/material.dart';

class QuestionCheckboxPage2 extends StatefulWidget {
  const QuestionCheckboxPage2({super.key});

  @override
  State<QuestionCheckboxPage2> createState() => _QuestionCheckboxPage2State();
}

class _QuestionCheckboxPage2State extends State<QuestionCheckboxPage2> {
  String? selectedOption;

  bool get hasSelection => selectedOption != null;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 51),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Apa yang mendasari \njawabanmu tersebut?',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Pilih alasan anda memilih jawaban itu.',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildOptionItem('Jumlah penjualan gaun terbanyak.',
                  Icons.trending_up, screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildOptionItem('Jumlah complain paling sedikit.',
                  Icons.trending_down, screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildOptionItem(
                  'Perbandingan jumlah complain\ndengan jumlah penjualannya.',
                  Icons.keyboard_option_key,
                  screenWidth),
              const Spacer(),
              AnimatedOpacity(
                opacity: hasSelection ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: hasSelection ? 56 : 0,
                  width: double.infinity,
                  child: hasSelection
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/interactive');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D2939),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(String text, IconData iconData, double screenWidth) {
    final isSelected = selectedOption == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = isSelected ? null : text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconData,
              size: screenWidth * 0.06,
              color: const Color(0xFF1F2937),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ),
            const SizedBox(width: 10),
            AnimatedCheckbox(isChecked: isSelected),
          ],
        ),
      ),
    );
  }
}

class AnimatedCheckbox extends StatefulWidget {
  final bool isChecked;

  const AnimatedCheckbox({
    super.key,
    required this.isChecked,
  });

  @override
  State<AnimatedCheckbox> createState() => _AnimatedCheckboxState();
}

class _AnimatedCheckboxState extends State<AnimatedCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isChecked) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isChecked != oldWidget.isChecked) {
      if (widget.isChecked) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: widget.isChecked ? const Color(0xFF1F2937) : Colors.transparent,
        border: Border.all(
          color: widget.isChecked
              ? const Color(0xFF1F2937)
              : const Color(0xFF6B7280),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: widget.isChecked
          ? Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: const Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            )
          : null,
    );
  }
}
