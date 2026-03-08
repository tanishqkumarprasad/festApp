import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/button.dart';
import '../../../logic/bloc/admin/admin_bloc.dart';
import '../../../logic/bloc/admin/admin_event.dart';
import '../../../logic/bloc/admin/admin_state.dart';

class AdminNoticePage extends StatefulWidget {
  const AdminNoticePage({super.key});

  @override
  State<AdminNoticePage> createState() => _AdminNoticePageState();
}

class _AdminNoticePageState extends State<AdminNoticePage> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _registrationLinkController = TextEditingController();

  DateTime? _selectedDate;
  File? _imageFile;
  File? _pdfFile;

  @override
  void dispose() {
    _eventNameController.dispose();
    _descriptionController.dispose();
    _registrationLinkController.dispose();
    super.dispose();
  }

  // --- FILE PICKING LOGIC ---
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // --- SUBMIT LOGIC ---
  void _onPostPressed() {
    // 1. Validate that all required fields and files are provided
    if (_eventNameController.text.isEmpty ||
        _selectedDate == null ||
        _imageFile == null ||
        _pdfFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select both files!')),
      );
      return;
    }

    // 2. Send the specific named parameters to the Bloc
    context.read<AdminBloc>().add(PostNotice(
      eventName: _eventNameController.text.trim(),
      eventDate: _selectedDate!,
      registrationLink: _registrationLinkController.text.trim(),
      otherDetails: _descriptionController.text.trim(),
      imageFile: _imageFile!,
      pdfFile: _pdfFile!,
    ));
  }

  void _clearForm() {
    _eventNameController.clear();
    _descriptionController.clear();
    _registrationLinkController.clear();
    setState(() {
      _selectedDate = null;
      _imageFile = null;
      _pdfFile = null;
    });
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
        title: const Text('Post Event Notice', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: BlocConsumer<AdminBloc, AdminState>(
          listener: (BuildContext context, AdminState state) {
            if (state is AdminActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              _clearForm();
            } else if (state is AdminActionError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (BuildContext context, AdminState state) {
            final bool isLoading = state is AdminActionProgress;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Event Details'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Event Name', hint: 'e.g. Hackathon 2026', controller: _eventNameController),
                  const SizedBox(height: 12),

                  // Date Picker Field
                  GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: _buildTextField(
                        label: 'Event Date',
                        hint: _selectedDate == null ? 'Tap to select date' : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                        controller: TextEditingController(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  _buildTextField(label: 'Registration Link', hint: 'https://forms.gle/...', controller: _registrationLinkController),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Other Details', hint: 'Rules, prizes, etc.', controller: _descriptionController, maxLines: 3),

                  const SizedBox(height: 24),
                  _buildSectionTitle('Event Files'),
                  const SizedBox(height: 12),

                  // Image Picker Button
                  GestureDetector(
                    onTap: _pickImage,
                    child: _buildAttachmentBox(
                      icon: Icons.image_outlined,
                      title: 'Event Poster (Image)',
                      subtitle: _imageFile != null ? _imageFile!.path.split('/').last : 'Tap to select an image from gallery',
                      isSelected: _imageFile != null,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // PDF Picker Button
                  GestureDetector(
                    onTap: _pickPdf,
                    child: _buildAttachmentBox(
                      icon: Icons.picture_as_pdf_outlined,
                      title: 'Rulebook (PDF)',
                      subtitle: _pdfFile != null ? _pdfFile!.path.split('/').last : 'Tap to select a PDF document',
                      isSelected: _pdfFile != null,
                    ),
                  ),

                  const SizedBox(height: 32),
                  AppButton(
                    text: isLoading ? 'Uploading & Saving...' : 'Post Notice',
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
    return Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600));
  }

  Widget _buildTextField({required String label, required String hint, required TextEditingController controller, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1E293B))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentBox({required IconData icon, required String title, required String subtitle, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? AppColors.primary : const Color(0xFF1E293B)),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : const Color(0xFF1E293B)),
            child: Icon(icon, color: isSelected ? AppColors.primary : Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: isSelected ? Colors.white : Colors.white60, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}