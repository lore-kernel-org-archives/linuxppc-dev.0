Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: <linuxppc-dev@lists.linuxppc.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: X works somewhat on DFP with latest radeonfb.c
Date: Sat, 17 Nov 2001 10:48:19 -0500
Cc: Daniel Berlin <dan@cgsoftware.com>, ghannon@cspi.com
MIME-Version: 1.0
Message-Id: <20011117154533.UWKB21717.tomts13-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

Thought you might like to know.  I took a look at the XF410
radeon_driver.c and compared it to the latest versions of radeon_driver.c
in XFreee86 CVS HEAD and they are quite different.

CVS HEAD has a *lot* more support for DFP but since I had the radeonfb
working on the DFP I thought what the hell, and started to try to use XF
4.1.0 radeon_driver.c with only a few small tweaks (ignoring all of the
Flat Panel code which is old and not-working in XF410) with the UseFBDev
Option so all the DFP register stuff is handled by the radeonfb.c driver.

X actually starts up with depths of 8 and depths of 24 (32bpp), and works
but the colors are all wrong:  too many pinks in the 8 bit version and
seemingly random colors in the 24 depth.

So I am going to try and play around with the pallette setting.

Anyway, the nice thing is we are getting close!

I hope they release XF 4.X soon with all the DFP fixes so that I can try
driving the board directly and not use the FrameBuffer which will help me
figure out which one is the culprit.

I tried building CVS HEAD but it was clear that a number of files were not
in a buildable state (missing braces, etc).

Do you know of any tree I could grab that is buildable and does have the
most recent DFP support it in?  I chose HEAD.  Should I have chosen a
specific branch (4.1.99?) instead?

Take care.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
