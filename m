Date: Sat, 28 Sep 2002 21:19:42 -0800
From: Ethan Benson <erbenson@alaska.net>
To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: [ANN] yaboot 1.3.7 && mailing lists
Message-ID: <20020929051942.GA29764@plato.local.lan>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yaboot 1.3.7 has been released, this is purely a maintenance release to
fix some minor bugs that have been discovered since 1.3.6.  The yaboot
1.x code base is in maintenance mode as all development efforts are
being centered on rewriting yaboot from scratch for a 2.0 release.

Unless you have been affected by one of the fixed bugs, there is no
compelling reason to upgrade.

Also some related news; yaboot now has mailing lists:

yaboot-announce         Announcements regarding yaboot (read-only)
yaboot-users            User related questions/discussion regarding yaboot
yaboot-devel            Technical and development discussion regarding yaboot

Please see http://lists.penguinppc.org/LISTNAME (where LISTNAME is one
of the above mentioned lists) for subscription info.

along with the #yaboot irc channel on irc.freenode.net.

Changes since 1.3.6:

        * Documentation:
          - Add German translation of yaboot-howto.
          - Small updates to yaboot-howto.
          - No longer tell people to send bugs to benh in yabootconfig(8).

        * yaboot:
          - Fix file search so IBM CHRP will work if there is more than
            one type 0x83 partition.
          - Fix possible reiserfs symlink resolution failure.

        * yabootconfig:
          - Fix corner case /etc/fstab parsing failure. (Debian bug#156742).

        * Small build system modifications (mostly to accommodate the use of
          the arch revision control system.

        * yaboot now includes two changelogs: "ChangeLog" which is a
          detailed automatically generated list of changes, and "changelog"
          (this file) which is a hand written understandable summary of
          changes between releases.

http://penguinppc.org/projects/yaboot/
and
http://www.alaska.net/~erbenson/yaboot/

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
