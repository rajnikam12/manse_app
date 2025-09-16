import 'package:flutter/material.dart';
import 'package:manse_app/models/leaders.dart';
import 'package:manse_app/pages/widgets/custom_card.dart';
import 'package:manse_app/repo/leaders_repo.dart';

class LeadersPage extends StatefulWidget {
  const LeadersPage({super.key});

  @override
  State<LeadersPage> createState() => _LeadersPageState();
}

class _LeadersPageState extends State<LeadersPage> {
  final LeadersRepository _leadersRepo = LeadersRepository();
  List<Leader> _leaders = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLeaders();
  }

  Future<void> _loadLeaders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final leaders = await _leadersRepo.fetchAll(limit: 20);
      setState(() {
        _leaders = leaders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load leaders. Please try again.';
      });
      debugPrint('Error loading leaders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                'Our Leaders:',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 10),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _loadLeaders,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _errorMessage != null
                      ? ListView(
                          children: [
                            SizedBox(height: 100),
                            Center(
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: _loadLeaders,
                                child: Text('Retry'),
                              ),
                            ),
                          ],
                        )
                      : _leaders.isEmpty
                      ? ListView(
                          children: [
                            SizedBox(height: 100),
                            Center(child: Text('No leaders found')),
                          ],
                        )
                      : ListView.builder(
                          itemCount: _leaders.length,
                          itemBuilder: (context, index) {
                            final leader = _leaders[index];
                            return CustomCard(
                              name: leader.name,
                              role: leader.role,
                              imageUrl: leader.imageUrl,
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
}
