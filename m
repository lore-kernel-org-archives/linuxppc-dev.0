Date: Mon, 19 Jul 2004 08:15:41 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: list of 2.6-related migration issues for embedded programmers?
Message-ID: <Pine.LNX.4.60.0407190807450.9101@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   on the topic of lists of things, is there a list somewhere of the
potentially important 2.6-related issues someone should at least
understand before migrating from 2.4 to 2.6?  i don't mean just
improvements in the kernel from 2.4 to 2.6; i mean significantly new
features that would require a rethinking and possible redesign of the
build process.  as examples off the top of my head:

   - replace devfs with udev:  currently, even with my current 8xx 2.6
build, i'm sticking with devfs until i'm confident i understand enough
to move up.

   - initramfs:  currently, i'm still using a zImage.initrd-based
image, and all i know about initramfs is that it's checked for at boot
time.  should i care about it?  at some point, probably, i'm sure.

   - redesign of modules and device drivers to be 2.6-compatible,
that's a biggie.  and the fact that the CVS busybox tree just recently
had 2.6 support added to its modules-related commands.

   - totally redesigned kernel config menus

   at the moment, i'm going through the 5-part series on migrating to
2.6 starting at http://linuxdevices.com/articles/AT3855888078.html.
some of it's useful, some of it's kind of fluffy.  but it would be
nice to have a list of that type aimed primarily at embedded
developers.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
