From: Josh Huber <huberj@WPI.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14452.12768.414652.630515@wpi.WPI.EDU>
Date: Thu, 6 Jan 2000 01:10:40 -0500 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: pcmcia on PB G3?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hey, I've seen stuff about this on the list prior to this, but when I go and try to get this working myself, I always get kernel panics.

I've tried using both the debian package (which is version 3.1.8 or pcmcia-cs), and the tarball from sourceforge.org/pcmcia. (in the NEW directory, there is a 3.1.9 which build MUCH better than the tarball form 3.1.8 on said site).

The modules, and cardmgr load fine with no errors, and tells me that it's watching two sockets.

If I try and insert any card (even my DVD decoder card, which it shouldn't do anything with, right?), I get a kernel panic.

What's the best way to capture said panic to disk? Or does someone here know what's going on?

Another thing I've noticed is that when I try a cardctl eject 0/1 it behaves as if the card were ejected, but doesn't eject it.  Does it need to do extra because I've got a  Wallstreet (springloaded ejection)?

My goal is to get the wavelan driver working to use wireless ethernet in Linux (works great in Mac OS! :)  Anyone else have one of these?

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
