import 'package:flutter/material.dart';

void main() {
  runApp(const CampusConnectApp());
}

class CampusConnectApp extends StatelessWidget {
  const CampusConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusConnect',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: Colors.blueAccent,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const MainWrapper(),
    );
  }
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const FeedScreen(),
    const SearchScreen(),
    const UploadScreen(),
    const EventsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'CampusConnect',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            fontSize: 20,
            letterSpacing: 1.2, // Added to mimic the 'Orbitron' look slightly
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.send_rounded, // Replacement for paperPlane
              size: 22,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded, // Replacement for bell
              size: 22,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemBuilder: (context, index) => PostCard(postIndex: index),
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final int postIndex;

  const PostCard({
    super.key,
    required this.postIndex,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool isBookmarked = false;
  int likeCount = 42;

  final List<Map<String, dynamic>> _samplePosts = [
    {
      'name': 'Sarah Chen',
      'role': 'Software Engineering Student',
      'content': 'Building CampusConnect for the Hackathon! 🚀 #Flutter #Innovation',
      'image': 'https://picsum.photos/seed/campus1/600/400',
      'timeAgo': '2 hours ago',
      'comments': 15,
    },
    {
      'name': 'Alex Rodriguez',
      'role': 'Computer Science Major',
      'content': 'Just finished my AI project presentation! 🤖 #MachineLearning #AI',
      'image': 'https://picsum.photos/seed/campus2/600/400',
      'timeAgo': '4 hours ago',
      'comments': 8,
    },
  ];

  @override
  void initState() {
    super.initState();
    likeCount = 30 + (widget.postIndex * 7);
  }

  Map<String, dynamic> get currentPost {
    return _samplePosts[widget.postIndex % _samplePosts.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          bottom: BorderSide(color: Colors.white10, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(
                currentPost['name'][0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              currentPost['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              currentPost['role'],
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white54,
              ),
              onSelected: (String value) {
                if (value == 'save') setState(() => isBookmarked = !isBookmarked);
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'save',
                  child: Row(
                    children: [
                      Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      Text(isBookmarked ? 'Unsave' : 'Save', style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share_outlined, color: Colors.white70),
                      SizedBox(width: 8),
                      Text('Share', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'report',
                  child: Row(
                    children: [
                      Icon(Icons.report_outlined, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Report', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              color: const Color(0xFF1A1A1A),
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(currentPost['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                          likeCount += isLiked ? 1 : -1;
                        });
                      },
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 24,
                        color: isLiked ? Colors.red : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Icon(Icons.mode_comment_outlined, size: 22, color: Colors.white),
                    const SizedBox(width: 20),
                    const Icon(Icons.send_outlined, size: 22, color: Colors.white),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Endorse Skill',
                        style: TextStyle(color: Colors.blueAccent, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '$likeCount likes',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${currentPost['name']} ',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
                      ),
                      TextSpan(
                        text: currentPost['content'],
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                if (currentPost['comments'] > 0)
                  Text(
                    'View all ${currentPost['comments']} comments',
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                const SizedBox(height: 4),
                Text(
                  currentPost['timeAgo'],
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ... Remaining Screen Classes (SearchScreen, UploadScreen, etc.) stay the same but use Material Icons
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Center(child: Icon(Icons.search, size: 100, color: Colors.blueAccent)),
    );
  }
}

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Center(child: Icon(Icons.add_box_outlined, size: 100, color: Colors.blueAccent)),
    );
  }
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Center(child: Icon(Icons.school_outlined, size: 100, color: Colors.blueAccent)),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Center(child: Icon(Icons.person_outline, size: 100, color: Colors.blueAccent)),
    );
  }
}