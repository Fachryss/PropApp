import 'package:flutter/material.dart';

class QuestionCheckboxPage2 extends StatefulWidget {
  const QuestionCheckboxPage2({super.key});

  @override
  State<QuestionCheckboxPage2> createState() => _QuestionCheckboxPageState();
}

class _QuestionCheckboxPageState extends State<QuestionCheckboxPage2> {
Map<String, bool> options = {
  'Jumlah penjualan gaun terbanyak.': false,
  'Jumlah complain paling sedikit.': false,
  'Perbandingan jumlah complain\ndengan jumlah penjualannya.': false,
};

  bool get hasSelection => options.values.any((isSelected) => isSelected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Apa yang mendasari\njawabanmu tersebut?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pilihlah berdasarkan analisismu dari masalah sebelumnya.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              _buildOptionItem('Jumlah penjualan gaun terbanyak.', Icons.trending_up, options['Jumlah penjualan gaun terbanyak.']!),
              const SizedBox(height: 16),
              _buildOptionItem('Jumlah complain paling sedikit.', Icons.trending_down, options['Jumlah complain paling sedikit.']!),
              const SizedBox(height: 16),
              _buildOptionItem('Perbandingan jumlah complain\ndengan jumlah penjualannya.', Icons.trending_neutral, options['Perbandingan jumlah complain\ndengan jumlah penjualannya.']!),
              const Spacer(),
              // Next button that appears only when at least one option is selected
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
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                            child: const Text(
                            'Go to next question',
                            style: TextStyle(
                              fontSize: 16,
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

  Widget _buildOptionItem(String text, IconData iconData, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          options[text] = !options[text]!;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side with icon and text
          Row(
            children: [
              Icon(
                iconData,
                size: 24,
                color: Colors.black54,
              ),
              const SizedBox(width: 16),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          // Animated checkbox
          AnimatedCheckbox(isChecked: isSelected),
        ],
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

class _AnimatedCheckboxState extends State<AnimatedCheckbox> with SingleTickerProviderStateMixin {
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
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: widget.isChecked ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        border: Border.all(
          color: widget.isChecked ? Colors.blue : Colors.black45,
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: widget.isChecked ? Center(
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
                  color: Colors.blue,
                ),
              ),
            );
          },
        ),
      ) : null,
    );
  }
}