Mime-Version: 1.0
Message-Id: <p04330100b60777284ff4@[129.59.235.75]>
In-Reply-To: <200010070500.AAA10239@lists.linuxppc.org>
References: <200010070500.AAA10239@lists.linuxppc.org>
Date: Mon, 9 Oct 2000 08:30:33 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "Marcus H. Mendenhall" <mendenmh@telalink.net>
Subject: Anyone succeed with VNC?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been trying to get VNC (http://www.uk.research.att.com/vnc/)
up and running under Linux-ppc.  I have used it under MacOS and seen
it used under Linux-x86, and it is a great package.

Unfortunately, it is hard to find for Linux-ppc.  The website (above)
points to an rpm hosted at ppc.linux.or.jp, but that server never
responds..  I have poked all around the linux.or.jp servers with no
luck.

Over the weekend, I broke down and decided to try to build it.  The X
version of it is based on XF86 source, and (with only minor
modifications to the linux.cf file to recognize powerpc architecture)
it built fine.  However, when run, it produces slightly muddled
screen displays, and crashes after window dragging or other large
operations.

Has anyone out there succeeded with VNC, or does anyone know where
the rpms which apparently existed once have gone?  It would be very
useful to return this package to Linux-ppc compatibility.  I can put
in a little time working on it, but have no familiarity with the
innards of an XF86 server, so if I could enlist some help from
someone who has poked at that package before, it might greatly
improve the likelihood of my getting this done in finite time.

Thanks.

Marcus Mendenhall

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
