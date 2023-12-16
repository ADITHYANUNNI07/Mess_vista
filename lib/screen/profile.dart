import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shalom_mess/auth/auth.dart';
import 'package:shalom_mess/screen/login_signup.dart';
import 'package:shalom_mess/widget/widget.dart';

class ProfileScrn extends StatelessWidget {
  const ProfileScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        padding: const EdgeInsets.only(
          top: 15,
        ),
        color: const Color(0Xff188F79).withOpacity(0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Profile',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              // user?.profilepic != null
              //     ? CircleAvatar(
              //         radius: size.width / 3,
              //         backgroundImage: FileImage(File(user!.profilepic!)),
              //       )
              //     :
              CircleAvatar(
                  radius: size.width / 4,
                  backgroundImage: const AssetImage('Assets/images/user.png')),
              const SizedBox(height: 10),
              Text(
                'user!.name',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'user.email',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(7),
                width: size.width - 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                ),
                child: Column(
                  children: [
                    AccountListTileWidget(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           EditProfileScrn(user: user),
                          //     ));
                        },
                        title: 'Edit Profile',
                        leadingIcon: LineAwesomeIcons.user_edit,
                        trailingIcon: LineAwesomeIcons.angle_right),
                    AccountListTileWidget(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const FeedbackScrn(),
                          //   ),
                          // );
                        },
                        title: 'User feedback',
                        leadingIcon: Icons.feedback,
                        trailingIcon: LineAwesomeIcons.angle_right),
                    AccountListTileWidget(
                      onTap: () {},
                      title: 'Share Application',
                      leadingIcon: Icons.share,
                    ),
                    AccountListTileWidget(
                      onTap: () async {},
                      title: 'Privacy Policy',
                      leadingIcon: Icons.privacy_tip,
                    ),
                    AccountListTileWidget(
                      onTap: () {
                        deleteaccount(context);
                      },
                      title: 'Delete Account',
                      leadingIcon: Icons.delete,
                    ),
                    const Divider(),
                    AccountListTileWidget(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Logout"),
                                content: const Text(
                                    "Are you sure you want to logout?"),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0Xff188F79)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0Xff188F79)),
                                    onPressed: () async {
                                      AuthServiceclass authService =
                                          AuthServiceclass();
                                      authService.signOut().whenComplete(
                                            () => Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              // the new route
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const LoginScreen(),
                                              ),

                                              (Route route) => false,
                                            ),
                                          );
                                    },
                                    child: const Text("Yes"),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        title: 'Logout',
                        leadingIcon: Icons.logout,
                        trailingIcon: LineAwesomeIcons.angle_right),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

void deleteaccount(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure you want to Delete your Account ?"),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0Xff188F79)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0Xff188F79)),
            onPressed: () async {
              // await deleteUserData(user.email);
              // AuthService authService = AuthService();
              // authService.signOut().whenComplete(
              //       () => Navigator.of(context).pushAndRemoveUntil(
              //         MaterialPageRoute(
              //           builder: (BuildContext context) => const LoginScrn(),
              //         ),
              //         (Route route) => false,
              //       ),
              //     );
            },
            child: const Text("Yes"),
          )
        ],
      );
    },
  );
}
