Date: Wed, 3 Jan 2001 13:49:43 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: iain@sandoe.co.uk
Subject: esound and 2.2's dmasound
Message-ID: <Pine.LNX.4.21L.0101031316190.1374-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With the latest versions of esound (0.2.22), xmms (1.2.4), and running
kernel.org's 2.2.18 final, I was *still* getting the
sound-plays-way-too-fast bug, in xmms, mpg123, and myth2 (all of which use
esound).

Following Henry Worth's emails from a while back, I tried the 2.4 dmasound
backport (http://www.drfruitcake.com/linux/linuxppc.html). It mostly
applied (one Makefile needed a little tweaking).

With dmasound built in, nothing happened at all. /dev/sndstat said no such
file or directory, mixers wouldn't work, and AWACS didn't even show up in
the interrupt list.

However, with dmasound as a module (and 'alias sound dmasound_pmac' in
/etc/modules.conf), everything (including esound) works perfectly.

So:
- 2.2.18 final and esound still don't play well together
- the 2.4 dmasound backport doesn't work compiled in (and probably could be
  updated for 2.2.18)

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
