import '../models/news_model.dart';

class NewsData {
  static const List<NewsModel> news = [
    NewsModel(
      category: 'Technology',
      title: 'The Future of Technology Is Changing Fast',
      description:
      'Discover the latest technology stories and innovations happening around the world.',
      time: '2 hours ago',
      image: 'assets/images/technology.jpg',
    ),
    NewsModel(
      category: 'Business',
      title: 'Global Markets Show Strong Growth',
      description:
      'Markets continue to change as businesses adapt to new opportunities.',
      time: '4 hours ago',
      image: 'assets/images/business.jpg',
    ),
    NewsModel(
      category: 'Sports',
      title: 'Big Match Ends With an Exciting Result',
      description:
      'Fans witnessed an exciting match with an unexpected result.',
      time: '5 hours ago',
      image: 'assets/images/sports.jpg',
    ),
    NewsModel(
      category: 'Health',
      title: 'New Health Trends You Should Know',
      description:
      'Experts share important information about modern health and wellness.',
      time: '6 hours ago',
      image: 'assets/images/health.jpg',
    ),
  ];
}