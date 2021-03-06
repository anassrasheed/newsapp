class User {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? mobileNumber;

  User(
      {this.uid,
      this.email,
      this.displayName,
      this.photoUrl,
      this.mobileNumber});

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, phoneNumber : $mobileNumber)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.uid == uid &&
        o.email == email &&
        o.displayName == displayName &&
        o.photoUrl == photoUrl &&
        o.mobileNumber == mobileNumber;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoUrl.hashCode ^
        mobileNumber.hashCode;
  }
}

class UserParam {
  final String? email;
  final String? password;
  final SignIn? signIn;
  final SignUp? signUp;
  UserParam({
    this.email,
    this.password,
    this.signIn,
    this.signUp,
  });
}

enum SignIn {
  anonymously,
  withApple,
  withGoogle,
  withEmailAndPassword,
}
enum SignUp { withEmailAndPassword }
