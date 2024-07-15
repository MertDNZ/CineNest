//Base URL and API key
const String baseUrl = "api.themoviedb.org";
const String apiKey = "31e1b4a67ee5b8aa3707babafcb8d1e6";
const String posterUrl = "https://image.tmdb.org/t/p/w500";
const String baseYoutubeUrl = "www.youtube.com/watch?v=";

//Endpoints
const String trendingMoviesEndpoint = "/3/trending/movie/week";
const String popularMoviesEndpoint = "/3/movie/popular";
const String topRatedMoviesEndpoint = "/3/movie/top_rated";
const String genresEndpoint = "/3/genre/movie/list";
const String discoverEndpoint = "/3/discover/movie";
const String searchEndpoint = "/3/search/movie";
const String movieEndpoint = "/3/movie/";
//default parameters
const Map<String, dynamic> queryParameters = {
  'api_key': apiKey,
  'adult': 'false',
};

//Texts
const String trendingMoviesText = "Trending Movies";
const String popularMoviesText = "Popular Movies";
const String topRatedMoviesText = "Top Rated Movies";
const String popularityText = "Popularity: ";
const String totalVoteText = "Total Vote: ";
const String releaseDateText = "Release Date: ";
const String voteAverageText = "Average Vote: ";
const String noVideosText = "No videos found";

//Appbar texts
const String discoverText = "Discover Movies";

//Dialog texts
const String imageFailedDialogString = "Failed to load image";

//Button texts
const String refreshButtonString = "Refresh";
