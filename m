Date: Tue, 3 Apr 2001 23:09:11 -0400 (EDT)
From: Bill Fink <billfink@capu.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: billfink@capu.net
Subject: Hang Mounting HFS CDROM with 2.4.3 final kernel
Message-ID: <Pine.LNX.4.21.0104032257570.782-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With a BenH 2.4.3 final kernel, if I do:

	mount -t hfs /dev/cdrom /mnt

the system locks up solid (mouse stops moving and can't switch to
a virtual console) with no error messages (I also tried it from a
virtual console but no error messages there either).  The only
recourse is to hit the reset button to power cycle the machine.
This is using the built-in DVD ROM drive on a dual G4 (but only
running a UP kernel).  I can mount an HFS disk without any problem.

This isn't actually a major issue to me personally (at least at
the moment), but I thought I should go ahead and report it.  I
discovered it because I was trying to get the MacOS ROM file from
my MacOS 9.0.4 CDROM for use with MOL.

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
