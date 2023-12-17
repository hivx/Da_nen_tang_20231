import 'package:anti_facebook_app/models/post.dart';
import 'package:anti_facebook_app/models/story.dart';

class User {
  late int? id;
  late String name;
  late String avatar;
  late bool? verified;
  late String? cover;
  late int? friends;
  late int? likes;
  late int? followers;
  late List<String>? hobbies;
  late List<Story>? stories;
  late List<User>? topFriends;
  late String? hometown;
  List<SocialMedia>? socialMedias;
  late String? bio;
  late String? type;
  late List<Education>? educations;
  late bool? guard;
  late List<Post>? posts;
  late String? pageType;
  late String? address;
  User({
    this.id,
    required this.name,
    required this.avatar,
    this.verified,
    this.cover,
    this.friends,
    this.likes,
    this.followers,
    this.hobbies,
    this.stories,
    this.topFriends,
    this.hometown,
    this.socialMedias,
    this.bio,
    this.type,
    this.educations,
    this.guard,
    this.posts,
    this.pageType,
    this.address,
  });

  User copyWith({
    int? id,
    String? name,
    String? avatar,
    bool? verified,
    String? cover,
    int? friends,
    int? likes,
    int? followers,
    List<String>? hobbies,
    List<Story>? stories,
    List<User>? topFriends,
    String? hometown,
    List<SocialMedia>? socialMedias,
    String? bio,
    String? type,
    List<Education>? educations,
    bool? guard,
    List<Post>? posts,
    String? pageType,
    String? address,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      verified: verified ?? this.verified,
      cover: cover ?? this.cover,
      friends: friends ?? this.friends,
      likes: likes ?? this.likes,
      followers: followers ?? this.followers,
      hobbies: hobbies ?? this.hobbies,
      stories: stories ?? this.stories,
      topFriends: topFriends ?? this.topFriends,
      hometown: hometown ?? this.hometown,
      socialMedias: socialMedias ?? this.socialMedias,
      bio: bio ?? this.bio,
      type: type ?? this.type,
      educations: educations ?? this.educations,
      guard: guard ?? this.guard,
      posts: posts ?? this.posts,
      pageType: pageType ?? this.pageType,
      address: address ?? this.address,
    );
  }

  User.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    print(id);
    name = json['name'];
    avatar = json['avatar'];
    verified = true;
    address = 'XM';
  }
}

class Education {
  final String majors;
  final String school;
  Education({
    required this.majors,
    required this.school,
  });
}

class SocialMedia {
  final String icon;
  final String name;
  final String link;
  SocialMedia({
    required this.icon,
    required this.name,
    required this.link,
  });
}
