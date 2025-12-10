import 'package:flutter/material.dart';

void main() {
  runApp(const MovieTrackerApp());
}

class MovieTrackerApp extends StatefulWidget {
  const MovieTrackerApp({Key? key}) : super(key: key);

  @override
  State<MovieTrackerApp> createState() => _MovieTrackerAppState();
}

class _MovieTrackerAppState extends State<MovieTrackerApp> {
  int _selectedIndex = 0;
  bool _useDarkTheme = true;

  late List<Movie> _movies;

  @override
  void initState() {
    super.initState();
    _movies = _generateSampleMovies();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleWatched(Movie movie) {
    setState(() {
      movie.isWatched = !movie.isWatched;
    });
  }

  void _toggleFavorite(Movie movie) {
    setState(() {
      movie.isFavorite = !movie.isFavorite;
    });
  }

  void _changeTheme(bool value) {
    setState(() {
      _useDarkTheme = value;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(
          key: const ValueKey('home'),
          movies: _movies,
        );
      case 1:
        return MovieListScreen(
          key: const ValueKey('movies'),
          movies: _movies,
          onToggleWatched: _toggleWatched,
          onToggleFavorite: _toggleFavorite,
        );
      case 2:
        return StatisticsScreen(
          key: const ValueKey('stats'),
          movies: _movies,
        );
      case 3:
        return FavoritesScreen(
          key: const ValueKey('favorites'),
          movies: _movies,
          onToggleWatched: _toggleWatched,
          onToggleFavorite: _toggleFavorite,
        );
      case 4:
        return SettingsScreen(
          key: const ValueKey('settings'),
          useDarkTheme: _useDarkTheme,
          onThemeChanged: _changeTheme,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieTracker',
      debugShowCheckedModeBanner: false,
      themeMode: _useDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F3FF),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF050816),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: false,
              title: _selectedIndex == 0
                  ? Row(
                      children: const [
                        CircleAvatar(
                          radius: 16,
                          // ganti dengan AssetImage kalau mau pakai foto lokal
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=47',
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('Halo, Suheti 👋'),
                      ],
                    )
                  : const Text('MovieTracker'),
            ),
            extendBody: true,
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: _GradientBackground(
                key: ValueKey(_selectedIndex),
                child: _buildBody(),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface.withOpacity(0.9),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: false,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.movie_filter_rounded),
                      label: 'Movies',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.analytics_rounded),
                      label: 'Stats',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_rounded),
                      label: 'Favorites',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings_rounded),
                      label: 'Settings',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// MODEL

class Movie {
  final String title;
  final String year;
  final String genre;
  final double rating;
  final String description;

  bool isWatched;
  bool isFavorite;

  Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.description,
    this.isWatched = false,
    this.isFavorite = false,
  });
}

List<Movie> _generateSampleMovies() {
  return [
    Movie(
      title: 'Inception',
      year: '2010',
      genre: 'Sci-Fi, Action',
      rating: 8.8,
      description:
          'Seorang pencuri yang mampu memasuki mimpi orang lain ditugaskan untuk menanamkan sebuah ide di dalam pikiran target.',
    ),
    Movie(
      title: 'Interstellar',
      year: '2014',
      genre: 'Sci-Fi, Drama',
      rating: 8.6,
      description:
          'Perjalanan sekelompok astronot melalui lubang cacing untuk mencari planet baru bagi umat manusia.',
    ),
    Movie(
      title: 'The Dark Knight',
      year: '2008',
      genre: 'Action, Crime',
      rating: 9.0,
      description:
          'Batman menghadapi Joker yang mengacaukan Gotham dengan kekacauan dan teror psikologis.',
    ),
    Movie(
      title: 'La La Land',
      year: '2016',
      genre: 'Romance, Musical',
      rating: 8.0,
      description:
          'Seorang aktris dan musisi jazz berjuang mengejar mimpi di Los Angeles.',
    ),
    Movie(
      title: 'Parasite',
      year: '2019',
      genre: 'Thriller, Drama',
      rating: 8.5,
      description:
          'Kisah dua keluarga dari kelas sosial berbeda yang saling terkait dengan cara yang tak terduga.',
    ),
    Movie(
      title: 'Spider-Man: Into the Spider-Verse',
      year: '2018',
      genre: 'Animation, Superhero',
      rating: 8.4,
      description:
          'Miles Morales menjadi Spider-Man dan bertemu Spider-People dari dimensi lain.',
    ),
    Movie(
      title: 'Your Name',
      year: '2016',
      genre: 'Animation, Romance',
      rating: 8.4,
      description:
          'Dua remaja yang saling bertukar tubuh dan berusaha menemukan satu sama lain.',
    ),
    Movie(
      title: 'The Social Network',
      year: '2010',
      genre: 'Drama, Biography',
      rating: 7.8,
      description:
          'Kisah pendirian Facebook dan konflik di balik layar antara para pendirinya.',
    ),
  ];
}

/// GRADIENT BACKGROUND

class _GradientBackground extends StatelessWidget {
  final Widget child;

  const _GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [
                  Color(0xFF050816),
                  Color(0xFF0B1021),
                  Color(0xFF16192F),
                ]
              : const [
                  Color(0xFFF5F3FF),
                  Color(0xFFEDE9FE),
                  Color(0xFFE0E7FF),
                ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: child,
      ),
    );
  }
}

/// HOME SCREEN

class HomeScreen extends StatelessWidget {
  final List<Movie> movies;

  const HomeScreen({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchedCount = movies.where((m) => m.isWatched).length;
    final favoriteCount = movies.where((m) => m.isFavorite).length;
    final total = movies.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Koleksi',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Total Film',
                  value: '$total',
                  icon: Icons.movie_filter_rounded,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Sudah Ditonton',
                  value: '$watchedCount',
                  icon: Icons.check_circle_rounded,
                  color: Colors.pinkAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Belum Ditonton',
                  value: '${total - watchedCount}',
                  icon: Icons.schedule_rounded,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Favorit',
                  value: '$favoriteCount',
                  icon: Icons.favorite_rounded,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Favorit Teratas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 170,
            child: movies.where((m) => m.isFavorite).isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada film favorit.\nTandai beberapa di tab Movies.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final favMovies =
                          movies.where((m) => m.isFavorite).toList();
                      final movie = favMovies[index];
                      return _FavoriteMovieCard(movie: movie);
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemCount: movies.where((m) => m.isFavorite).length,
                  ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0, end: 1),
      builder: (context, valueAnim, child) {
        return Transform.translate(
          offset: Offset(0, (1 - valueAnim) * 12),
          child: Opacity(
            opacity: valueAnim,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: colorScheme.surface.withOpacity(0.9),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.05),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: colorScheme.onPrimary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteMovieCard extends StatelessWidget {
  final Movie movie;

  const _FavoriteMovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_movieRoute(movie));
      },
      child: Hero(
        tag: 'hero-${movie.title}',
        child: Container(
          width: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                colorScheme.primaryContainer.withOpacity(0.9),
                colorScheme.secondaryContainer.withOpacity(0.8),
              ],
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.local_movies, size: 32),
              const SizedBox(height: 8),
              Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '${movie.year} • ${movie.genre}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 16),
                  const SizedBox(width: 4),
                  Text('${movie.rating}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// MOVIE LIST SCREEN – SEARCH + FILTER GENRE

class MovieListScreen extends StatefulWidget {
  final List<Movie> movies;
  final void Function(Movie) onToggleWatched;
  final void Function(Movie) onToggleFavorite;

  const MovieListScreen({
    Key? key,
    required this.movies,
    required this.onToggleWatched,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  String _searchQuery = '';
  String _selectedGenre = 'Semua';
  late List<String> _genres;

  @override
  void initState() {
    super.initState();
    _genres = _extractGenres(widget.movies);
  }

  List<String> _extractGenres(List<Movie> movies) {
    final set = <String>{};
    for (final movie in movies) {
      final parts = movie.genre.split(',');
      for (final p in parts) {
        final g = p.trim();
        if (g.isNotEmpty) set.add(g);
      }
    }
    final list = set.toList()..sort();
    list.insert(0, 'Semua');
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.movies.where((movie) {
      final matchesSearch = movie.title
          .toLowerCase()
          .contains(_searchQuery.toLowerCase().trim());
      final matchesGenre = _selectedGenre == 'Semua'
          ? true
          : movie.genre.toLowerCase().contains(_selectedGenre.toLowerCase());
      return matchesSearch && matchesGenre;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari film...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  value: _selectedGenre,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items: _genres
                      .map(
                        (g) => DropdownMenuItem(
                          value: g,
                          child: Text(
                            g,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedGenre = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 80),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final movie = filtered[index];

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Hero(
                    tag: 'hero-${movie.title}',
                    child: CircleAvatar(
                      radius: 24,
                      child: Text(
                        movie.title.isNotEmpty ? movie.title[0] : '?',
                      ),
                    ),
                  ),
                  title: Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('${movie.year} • ${movie.genre}'),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        tooltip: 'Tandai sudah ditonton',
                        icon: Icon(
                          movie.isWatched
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked,
                        ),
                        onPressed: () => widget.onToggleWatched(movie),
                      ),
                      IconButton(
                        tooltip: 'Favorit',
                        icon: Icon(
                          movie.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                        ),
                        onPressed: () => widget.onToggleFavorite(movie),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      _movieRoute(
                        movie,
                        onToggleFavorite: widget.onToggleFavorite,
                        onToggleWatched: widget.onToggleWatched,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// STATS SCREEN

class StatisticsScreen extends StatelessWidget {
  final List<Movie> movies;

  const StatisticsScreen({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = movies.length;
    final watched = movies.where((m) => m.isWatched).length;
    final favorite = movies.where((m) => m.isFavorite).length;
    final unwatched = total - watched;

    double _ratio(int part) => total == 0 ? 0 : part / total;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _StatProgressTile(
            label: 'Sudah Ditonton',
            value: watched,
            total: total,
            color: Colors.greenAccent,
            ratio: _ratio(watched),
          ),
          const SizedBox(height: 12),
          _StatProgressTile(
            label: 'Belum Ditonton',
            value: unwatched,
            total: total,
            color: Colors.amberAccent,
            ratio: _ratio(unwatched),
          ),
          const SizedBox(height: 12),
          _StatProgressTile(
            label: 'Favorit',
            value: favorite,
            total: total,
            color: Colors.pinkAccent,
            ratio: _ratio(favorite),
          ),
          const SizedBox(height: 24),
          const Text(
            'Rekomendasi Aksi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          const _HintBubble(
            icon: Icons.play_circle_outline,
            text:
                'Coba pilih 1–2 film baru untuk ditonton minggu ini dari tab Movies.',
          ),
          const SizedBox(height: 8),
          const _HintBubble(
            icon: Icons.favorite_border,
            text:
                'Tandai film yang kamu suka sebagai favorit supaya lebih mudah ditemukan.',
          ),
        ],
      ),
    );
  }
}

class _StatProgressTile extends StatelessWidget {
  final String label;
  final int value;
  final int total;
  final double ratio;
  final Color color;

  const _StatProgressTile({
    Key? key,
    required this.label,
    required this.value,
    required this.total,
    required this.ratio,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.surface.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label  •  $value / $total',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: ratio),
              builder: (context, valueAnim, _) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    value: valueAnim,
                    backgroundColor: color.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HintBubble extends StatelessWidget {
  final IconData icon;
  final String text;

  const _HintBubble({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

/// FAVORITES SCREEN

class FavoritesScreen extends StatelessWidget {
  final List<Movie> movies;
  final void Function(Movie) onToggleWatched;
  final void Function(Movie) onToggleFavorite;

  const FavoritesScreen({
    Key? key,
    required this.movies,
    required this.onToggleWatched,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = movies.where((m) => m.isFavorite).toList();

    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada film favorit.\nTambah dari tab Movies.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
      itemCount: favorites.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final movie = favorites[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Hero(
              tag: 'hero-${movie.title}',
              child: const Icon(Icons.favorite_rounded, size: 30),
            ),
            title: Text(movie.title),
            subtitle: Text('${movie.year} • ${movie.genre}'),
            trailing: IconButton(
              tooltip: 'Hapus dari favorit',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => onToggleFavorite(movie),
            ),
            onTap: () {
              Navigator.of(context).push(
                _movieRoute(
                  movie,
                  onToggleFavorite: onToggleFavorite,
                  onToggleWatched: onToggleWatched,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/// SETTINGS SCREEN

class SettingsScreen extends StatelessWidget {
  final bool useDarkTheme;
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({
    Key? key,
    required this.useDarkTheme,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
      children: [
        const ListTile(
          title: Text(
            'Pengaturan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SwitchListTile(
            title: const Text('Tema Gelap'),
            subtitle: const Text('Aktif/nonaktif tema gelap aplikasi'),
            value: useDarkTheme,
            onChanged: onThemeChanged,
            secondary: const Icon(Icons.dark_mode_rounded),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Icon(Icons.info_outline_rounded,
                color: colorScheme.primary),
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text(
              'MovieTracker demo dengan 5 layar, animasi, dan tema dinamis.',
            ),
          ),
        ),
      ],
    );
  }
}

/// DETAIL SCREEN + ROUTE ANIMASI

Route _movieRoute(
  Movie movie, {
  void Function(Movie)? onToggleFavorite,
  void Function(Movie)? onToggleWatched,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MovieDetailScreen(
      movie: movie,
      onToggleFavorite: onToggleFavorite,
      onToggleWatched: onToggleWatched,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetTween =
          Tween(begin: const Offset(0, 0.05), end: Offset.zero).chain(
        CurveTween(curve: Curves.easeOutCubic),
      );
      final fadeTween = Tween(begin: 0.0, end: 1.0);

      return SlideTransition(
        position: animation.drive(offsetTween),
        child: FadeTransition(
          opacity: animation.drive(fadeTween),
          child: child,
        ),
      );
    },
  );
}

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final void Function(Movie)? onToggleWatched;
  final void Function(Movie)? onToggleFavorite;

  const MovieDetailScreen({
    Key? key,
    required this.movie,
    this.onToggleWatched,
    this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: Icon(
              movie.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
            ),
            onPressed:
                onToggleFavorite != null ? () => onToggleFavorite!(movie) : null,
          ),
        ],
      ),
      floatingActionButton: onToggleWatched == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => onToggleWatched!(movie),
              icon: Icon(
                movie.isWatched
                    ? Icons.check_circle_rounded
                    : Icons.play_arrow_rounded,
              ),
              label: Text(
                movie.isWatched
                    ? 'Tandai belum ditonton'
                    : 'Tandai sudah ditonton',
              ),
            ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'hero-${movie.title}',
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primaryContainer,
                        colorScheme.secondaryContainer,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.local_movies_rounded,
                    size: 60,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${movie.year} • ${movie.genre}',
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 20),
                const SizedBox(width: 4),
                Text('${movie.rating} / 10'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Sinopsis',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              movie.description,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            const Text(
              'Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  avatar: Icon(
                    movie.isWatched
                        ? Icons.check_circle_rounded
                        : Icons.schedule_rounded,
                    size: 18,
                  ),
                  label: Text(
                    movie.isWatched ? 'Sudah ditonton' : 'Belum ditonton',
                  ),
                ),
                Chip(
                  avatar: Icon(
                    movie.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 18,
                  ),
                  label: Text(
                    movie.isFavorite ? 'Favorit' : 'Bukan favorit',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
