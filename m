From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Apple's role in GNU tools development
Date: Thu, 10 Feb 2000 21:08:43 -0500
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00021021143100.00574@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

In case you are interested in Apple's involvement with GNU tools, here is a
meesage that San Shebs (previous chief maintainer of gdb, posted to the gdb
mailing lists).

I certainly hope that when MacOS X does begin shipping that we can make MacOS
BSD binaries work under Linux for PPC and visa-versa.  Give normal BSD can rn
Linux binaries with a compatibilitity library this should be possible.
Furthermore there are projects currently which allow user level code to run a
"Linux kernel" in a user process and hopefully the (if we put our mind to it) a
way to run a BSD kernel (namely Darwin) in a process on a Linux PPC machines.

Either way, we should all benefit from Apple sponsored ppc improvements to the
GNU tools.

Kevin

  ----------  Forwarded Message  ---------- Subject: Status
Date: Thu, 10 Feb 2000 14:48:32 -0800
From: Stan Shebs <shebs@apple.com>


Just a quick note to let everybody know what is going on with
me and GDB.  After a brief career as a consultant (read: an
extended at-home vacation :-) ), Apple made me an offer that
would have been foolish to refuse, and so after nearly seven
years, I'm back at Apple.  But things have changed a lot -
the next generation Mac OS X is a real live BSD Unix system
with a GUI on top.  Indeed, according to the current plan,
OS X will be shipping on all new Macs soon, which will
effectively make it the first mass-market personal computer
with a Unix as the default OS.

And as if that weren't exciting enough, the development
is all done with GNU!  The tools team here has been madly
hacking on GCC and GDB.  Up to now, they've been mostly
scrambling to keep everything working for the OS bringup,
but in the long term, Apple wants to resync with the FSF
versions, and one of my tasks is to help make that happen.
This will certainly involve a combination of contributing
some patches, discarding others, and in some cases continuing
to maintain them separately.  We'll also be expanding the
development group, since there are a number of bigger projects
that Apple is interested in, such as faster compilation, better
PowerPC code, libgdb, and C++ debugging improvements.

Initially, my highest-priority activities for Apple will mainly
be related to GCC, although I will be working on GDB as well.
RMS is about ready to announce the new steering committee, and one
of its first jobs will be to decide how to run GDB maintenance
henceforth; this will be a chance to think about whether to
retain the status quo or to come up with a new system.  So if
you haven't already expressed yourself on the subject :-),
please tell everybody on this list how you wish things would
be done in the future.

Stan
shebs@apple.com
-------------------------------------------------------

--

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
