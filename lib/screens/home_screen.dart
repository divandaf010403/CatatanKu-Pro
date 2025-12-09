import 'package:flutter/material.dart';
import '../models/note.dart';
import 'note_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some sample notes
    _loadSampleNotes();
  }

  void _loadSampleNotes() {
    setState(() {
      notes = [
        Note.create(
          id: '1',
          title: 'Belanja Hari Ini',
          description: 'Susu, Roti, Telur, Sayuran',
        ),
        Note.create(
          id: '2',
          title: 'Meeting Tim',
          description: 'Diskusi proyek baru jam 14.00',
        ),
        Note.create(
          id: '3',
          title: 'Ide Aplikasi',
          description: 'Aplikasi tracking keuangan pribadi dengan AI',
        ),
      ];
    });
  }

  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void _updateNote(Note note) {
    setState(() {
      final index = notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        notes[index] = note;
      }
    });
  }

  void _deleteNote(String noteId) {
    setState(() {
      notes.removeWhere((note) => note.id == noteId);
    });
  }

  Future<void> _navigateToForm({Note? note}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteFormScreen(note: note),
      ),
    );

    if (result != null) {
      if (note == null) {
        // Add new note
        _addNote(result);
      } else {
        // Update existing note
        _updateNote(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatatanKu Pro'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada catatan',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tekan tombol + untuk menambah catatan baru',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Diperbarui: ${_formatDate(note.updatedAt)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _navigateToForm(note: note);
                        } else if (value == 'delete') {
                          _showDeleteConfirmation(note.id);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.blue),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Hapus'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _navigateToForm(note: note);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _showDeleteConfirmation(String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus catatan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteNote(noteId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Catatan berhasil dihapus'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}