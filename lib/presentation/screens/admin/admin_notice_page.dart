import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/button.dart';
import '../../../logic/bloc/admin/admin_bloc.dart';
import '../../../logic/bloc/admin/admin_event.dart';
import '../../../logic/bloc/admin/admin_state.dart';

enum AdminNoticeContentType { text, image, pdf }

class AdminNoticePage extends StatefulWidget {
  const AdminNoticePage({super.key});

  @override
  State<AdminNoticePage> createState() => _AdminNoticePageState();
}

class _AdminNoticePageState extends State<AdminNoticePage> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _authorityController = TextEditingController();
  final TextEditingController _textNoticeController = TextEditingController();

  AdminNoticeContentType _selectedType = AdminNoticeContentType.text;

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    _authorityController.dispose();
    _textNoticeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkBackground = Color(0xFF020617);

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Post Notice',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AdminBloc, AdminState>(
          listener: (BuildContext context, AdminState state) {
            if (state is AdminActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              _clearForm();
            } else if (state is AdminActionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (BuildContext context, AdminState state) {
            final bool isLoading = state is AdminActionProgress;

            return SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Basic details (all optional)'),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Subject',
                    hint: 'Enter subject of the notice (optional)',
                    controller: _subjectController,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Description',
                    hint: 'Short description for the notice (optional)',
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Sending authority',
                    hint: 'Who is sending this notice? (optional)',
                    controller: _authorityController,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Notice content type'),
                  const SizedBox(height: 12),
                  _buildContentTypeChips(),
                  const SizedBox(height: 16),
                  _buildContentInput(),
                  const SizedBox(height: 32),
                  AppButton(
                    text: isLoading ? 'Posting...' : 'Post notice',
                    variant: AppButtonVariant.primary,
                    size: AppButtonSize.large,
                    isLoading: isLoading,
                    onPressed: isLoading ? null : _onPostPressed,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
            filled: true,
            fillColor: const Color(0xFF0F172A),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFF1E293B), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentTypeChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildChip(
          label: 'Text',
          isSelected: _selectedType == AdminNoticeContentType.text,
          icon: Icons.notes,
          onTap: () => _onTypeChanged(AdminNoticeContentType.text),
        ),
        const SizedBox(width: 8),
        _buildChip(
          label: 'Image',
          isSelected: _selectedType == AdminNoticeContentType.image,
          icon: Icons.image_outlined,
          onTap: () => _onTypeChanged(AdminNoticeContentType.image),
        ),
        const SizedBox(width: 8),
        _buildChip(
          label: 'PDF',
          isSelected: _selectedType == AdminNoticeContentType.pdf,
          icon: Icons.picture_as_pdf_outlined,
          onTap: () => _onTypeChanged(AdminNoticeContentType.pdf),
        ),
      ],
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final Color selectedColor = AppColors.primary;
    final Color unselectedColor = const Color(0xFF1E293B);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected ? selectedColor : const Color(0xFF334155),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.white70,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentInput() {
    switch (_selectedType) {
      case AdminNoticeContentType.text:
        return _buildTextField(
          label: 'Notice text',
          hint: 'Write the full notice here (optional)',
          controller: _textNoticeController,
          maxLines: 5,
        );
      case AdminNoticeContentType.image:
        return _buildAttachmentPlaceholder(
          icon: Icons.image_outlined,
          title: 'Attach image (optional)',
          subtitle:
              'Tap to select an image file and then upload its URL in backend.',
        );
      case AdminNoticeContentType.pdf:
        return _buildAttachmentPlaceholder(
          icon: Icons.picture_as_pdf_outlined,
          title: 'Attach PDF (optional)',
          subtitle:
              'Tap to select a PDF file and then upload its URL in backend.',
        );
    }
  }

  Widget _buildAttachmentPlaceholder({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1E293B),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTypeChanged(AdminNoticeContentType type) {
    setState(() {
      _selectedType = type;
    });
  }

  void _onPostPressed() {
    final noticeData = <String, dynamic>{
      'subject': _subjectController.text.trim(),
      'description': _descriptionController.text.trim(),
      'authority': _authorityController.text.trim(),
      'contentType': switch (_selectedType) {
        AdminNoticeContentType.text => 'text',
        AdminNoticeContentType.image => 'image',
        AdminNoticeContentType.pdf => 'pdf',
      },
      'content': _textNoticeController.text.trim(),
    };

    context.read<AdminBloc>().add(PostNotice(noticeData));
  }

  void _clearForm() {
    _subjectController.clear();
    _descriptionController.clear();
    _authorityController.clear();
    _textNoticeController.clear();
    setState(() {
      _selectedType = AdminNoticeContentType.text;
    });
  }
}

