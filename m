Date: Wed, 28 Apr 1999 01:05:57 -0400 (EDT)
From: Satadru Pramanik <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Rel 5 ssh?
Message-ID: <Pine.LNX.4.10.9904280104180.19702-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've tried to rebuild the ssh-1.2.6 src.rpm under glibc2.1, and I get
these errors:
gcc -pipe -c -I.  -I./gmp-2.0.2-ssh-2 -DHAVE_CONFIG_H
-DHOST_KEY_FILE=\"/etc/ssh/ssh_host_key\"
-DHOST_CONFIG_FILE=\"/etc/ssh/ssh_config\"
-DSERVER_CONFIG_FILE=\"/etc/ssh/sshd_config\"
-DSSH_PROGRAM=\"/usr/bin/ssh1\" -DETCDIR=\"/etc/ssh\"
-DPIDDIR=\"/var/run\" -DSSH_BINDIR=\"/usr/bin\"
-DTIS_MAP_FILE=\"/etc/ssh/sshd_tis.map\" -O2 -fsigned-char
-I/usr/X11R6/include login.c
login.c: In function `record_login':
login.c:437: structure has no member named `ut_syslen'
login.c:441: structure has no member named `e_termination'
login.c:442: structure has no member named `e_exit'
login.c:454: `WTMPX_FILE' undeclared (first use in this function)
login.c:454: (Each undeclared identifier is reported only once
login.c:454: for each function it appears in.)
make: *** [login.o] Error 1
Bad exit status from /var/tmp/rpm-tmp.85594 (%build)


Any thoughts?  Does anybody know how to fix this?  The sshd from this
install can't allocate ptys either.

--=
satadru pramanik `satadru@umich.edu' www.umich.edu/~satadru
Online Editor, The Michigan Daily
Yugoslavia declares 'peace' in Kosovo; NATO Airstrikes
continue
-CNN Interactive, 04/08/99
=--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
