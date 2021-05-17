/*Parent testParent = Parent(
    parentFullname: "Anis Bejaoui",
    parentEmail: "anis@mail.com",
    parentPhoneNumber: "50100200",
    parentAvatarURL: "assets/images/p1.png");

class Parent {
  final String parentFullname;
  final String parentEmail;
  final String parentPhoneNumber;
  final String parentPassword;
  final String parentAvatarURL;

  Parent({
    this.parentFullname,
    this.parentEmail,
    this.parentPhoneNumber,
    this.parentPassword,
    this.parentAvatarURL,
  });

  factory Parent.fromMap(Map<String, dynamic> map) => Parent(
        parentFullname: map["parentFullname"],
        parentEmail: map["parentEmail"],
        parentAvatarURL: map["parentAvatarURL"],
        parentPassword: map["parentPasword"],
        parentPhoneNumber: map["parentPhoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "parentFullname": parentFullname,
        "parentEmail": parentEmail,
        "parentAvatarURL": parentAvatarURL,
        "parentPassword": parentPassword,
        "parentPhoneNumber": parentPhoneNumber
      };
}
*/
