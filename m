Date: Wed, 16 Aug 2000 15:42:36 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: problems w/ CT69000
In-Reply-To: <399A6578.906706B5@apus.co.at>
Message-ID: <Pine.GSO.4.21.0008161454070.5745-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello

I'm addressing you folks at ppc-embedded because frankly, I don't know how
to find any relevant info on this issue. We are developing a single-board
solution with a CT69000 display controller. I built the XFree 4.0.1 on a
development system (which also has a CT69000 on board, although its an
intel platform...) and well, it doesn't work properly. There are visible
artifacts (two vertical bars) at 24 bit pixel depth. Other modes (16bpp and
8bpp) work even less, thus being almost unusable. Can anyone point me in
the right direction? How can I find out whether the problem is in the
XFree86 chips.o driver or in the CT69000 chip / motherboard itself?
I tried to find some kind of "errata" or other experiences, but the
information on the CT69000 is very scarce, and since its mostly used for
embedded development, I figured out that some of you might know what to do
with this one or even experienced the same problem yourselves.

BTW, is there any good FAQ on how to boot Linux kernel from DINK32? I
haven't figured out any proper way to load blocks from a block device
(e.g. an IDE hard disk)

-topi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
