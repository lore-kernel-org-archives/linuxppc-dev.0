Date: Tue, 17 Jul 2001 00:44:06 -0400 (EDT)
From: Ryan Boder <boder@cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: booting new ibook dual
Message-ID: <Pine.LNX.4.21L-021.0107170037280.8924-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am trying to do an install on the ibook dual usb from an hfs
partition. None of the install options really work well. The only one that
boots is Install - Ultra safe mode. But when it does it says that this
system only supports Xpmac. Then when it starts Xpmac the colors are all
screwed up. All the others just hang as soon as the kernel starts up.

So I am thinking that the only problem here is the wrong kernel args are
being passed. Is that right or is the new ibook display not supported by
the install kernel for some reason? Can someone point me to documentation
on kernel args so I can figure out how to boot the ibook2 into the
graphical installer?


Ryan Boder
http://www.ece.cmu.edu/~rtb


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
