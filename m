Date: Sun, 15 Apr 2001 02:58:07 +0100
Subject: XF4/2.4.4p1/upgrade woes..
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org, benh@kernel.crashing.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010415015801.AC7B1DBAB6@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've just done the upgrade to XF4.0.99.2b and the 'necessary' other rpms to
enable this...

1/ 2.4.4-p1 I can't get it to build (from BK_2_4) without copying cputable.h
from ben's tree - is my BK tree broken - or is the file missing?

2/ I've lost all "special" keys, SysRq, VT switching etc. (I think this
happened as a result of the 'necessary' upgrades to other rpms - rather than
the XF4 install directly)...

3/ ati mach64 doesn't come up (log avail on request - it's rather large to
post)... do I need Ani's rsync tree?

I've tried with & without acceleration enabled...

(fbdev *does* work - but it's a bit of a backward step from Xpmac)...

any help appreciated...
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
