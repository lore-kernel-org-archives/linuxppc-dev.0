Date: Sun, 16 Apr 2000 22:15:00 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Anyone running LinuxPPC2000+PCMCIA+WallStreet?
Message-ID: <Pine.LNX.3.96.1000416220038.20340A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Folks,

We're trying to run a LinuxPPC 2000 install on a WallStreet M4753 and
trying to get PCMCIA going.  Of course, we've had loads of trouble.  ;-)

We've been trying with the pmac-2.2.15pre7 kernel and a variety of pcmcia
versions.  No matter what, we always get panics when inserting a card.

At this point we're pretty sure the problem is in i82365 or cardmgr, not a
specific card driver.  We're not getting far enough to deal w/ a
specific driver.  We've tried a couple of network cards, including
some that aren't supported by pcmcia-cs at all (we were hoping for
'successful' failure).

Any recommendations?  We'll send .configs and such if anyone wants to see
them.

Thanks,
-Mark

Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
