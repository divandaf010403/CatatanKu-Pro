import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteFormScreen extends StatefulWidget {
  final Note? note;

  const NoteFormScreen({super.key, this.note});

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.note != null;
    
    if (_isEditing) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final note = _isEditing
          ? Note(
              id: widget.note!.id,
              title: _titleController.text,
              description: _descriptionController.text,
              createdAt: widget.note!.createdAt,
              updatedAt: DateTime.now(),
            )
          : Note.create(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: _titleController.text,
              description: _descriptionController.text,
            );

      // Update the original note if editing
      if (_isEditing) {
        widget.note!.update(
          title: _titleController.text,
          description: _descriptionController.text,
        );
      }

      Navigator.pop(context, note);
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                
                // Title
                Text(
                  _isEditing ? 'Edit Catatan' : 'Tambah Catatan Baru',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    hintText: 'Masukkan judul catatan',
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul tidak boleh kosong';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                
                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    hintText: 'Masukkan deskripsi catatan',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi tidak boleh kosong';
                    }
                    return null;
                  },
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _saveNote(),
                ),
                const SizedBox(height: 20),
                
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Batal'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(_isEditing ? 'Perbarui' : 'Simpan'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Catatan' : 'Tambah Catatan'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  hintText: 'Masukkan judul catatan',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi catatan',
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
                maxLines: 8,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _saveNote(),
              ),
              const SizedBox(height: 20),
              
              // Show Bottom Sheet Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _showBottomSheet,
                  icon: const Icon(Icons.keyboard_arrow_up),
                  label: const Text('Tampilkan sebagai Bottom Sheet'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}