From: Miles Lane <miles.lane@comcast.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: linuxppc-2.5 (mvista rsync) -- Please push changesets for AGPGART / RadeonFB / Radeon DRI to Linus
Date: Sat, 2 Aug 2003 18:32:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308021832.08242.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

When I build and run a Linus kernel 2.5.72 - 2.6.0-test2 kernel,
the video gets thrown way out of sync when I start my Radeon
card with DRI enabled.  The symptom is twofold, the colormap
is all wrong and all I get is a very blurry, oversized pointer.  The
sync seems to be way out of whack.  Switching to a VT window
doesn't help.  In fact, the video in VT windows exhibits the
same problems.  I have tried switching back and forth repeatedly.
The only thing that fixes the problem is starting XFreee86 with
DRI disabled or rebooting.

I have a:
ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]

Also, if there are other changesets that should be in 2.6.0, this might
be a good time to get those in, right?

Thanks!

	Miles

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
